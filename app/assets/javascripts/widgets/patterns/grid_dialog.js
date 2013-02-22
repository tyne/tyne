(function($, exports) {
  function GridDialog(_target) {
    var _this = this;

    _this.$target = $(_target);
    _this.$link = $(_this.$target.find(".new_link")[0]);
    _this.$dialog = function() {
      var dialogs = _this.$target.find('[role="dialog"]:not(.issue_dialog)');
      if (dialogs.length > 0) {
        return $(dialogs[0]);
      }
      return Loader.load(_this.$target.data("dialog"), _this.$target);
    };
    _this.$form = function() {
      return $(_this.$dialog.call(_this).find("form")[0]);
    };
    _this.$grid = $(_this.$target.find(".grid")[0]);

    _this.resourceUrl = _this.$target.data("resource_url");

    _this.format = ".pjax";

    // TODO: Use human attribute name
    _this.modelName = "Project";
    _this.createTitle = I18n.t("helpers.submit.create",{model: this.modelName});
    _this.updateTitle = I18n.t("helpers.submit.update",{model: this.modelName});

    _this.validationEnabled = null;
    _this.formCallback = null;

    _this.attachEvents();
  };

  GridDialog.prototype.attachEvents = function() {
    var _this = this;

    // Open dialog when link clicked
    _this.$link.on("click", function(event) {
      _this.formCallback = _this.toNewForm(event);
    });

    // Open populated dialog when row clicked
    _this.$grid.find("tbody").on("click", "tr", function(event) {
      _this.formCallback = _this.toUpdateForm(event);
    });

    // Destroy element and remove from dom when destoy link clicked
    _this.$grid.find("tbody").on("click", "tr .destroy", function(event) {
      _this.destroy(event);
    });

    _this.$target.on("shown", '[role="dialog"]', function() {
      if (!_this.validationEnabled) _this.validationEnabled = $(ClientSideValidations.selectors.forms).validate();
      _this.$form.call(_this).resetClientSideValidations();
      _this.formCallback.call(_this);
    });

    _this.$target.on("hidden", '[role="dialog"]', function() {
      _this.$form.call(_this).resetClientSideValidations();
    });
  };

  GridDialog.prototype.toNewForm = function(event) {
    var _this = this;

    var _form = this.$form.call(this);

    _form.attr("action", _this.resourceUrl + _this.format);
    _form.find('input[type="submit"]').val(this.createTitle);
    this.$dialog.call(this).find("h3").text(this.createTitle);
    this.setMethod("post");
    this.populateForm({});

    var options = {
      success: function(responseText, status, xhr) {
        _this.$grid.find("tbody").append(responseText);
        _this.$dialog.call(_this).modal('hide');
        Notification.show('success', I18n.t("flash.actions.create.notice", {resource_name: _this.modelName}));
      }
    };

    // Remove id from uniqueness validator
    $.each(window.ClientSideValidations.forms[_form.attr("id")].validators, function(index, element) {
      if (!element.uniqueness) return;

      $.each(element.uniqueness, function(innerIndex, innerElement) {
        if (!innerElement.id) return;

        delete(innerElement.id);
      });
    });

    this.$dialog.call(this).modal('show');
    return function() { this.makeAjaxForm(options) };
  };

  GridDialog.prototype.toUpdateForm = function(event) {
    if ($(event.target).is(".destroy")) return;

    var _this = this;

    var $row = $(event.target).closest("tr");
    var data = $row.data("serialized");
    var editUrl = this.resourceUrl + "/" + data.id + _this.format;
    var _form = this.$form.call(this);

    _form.attr("action", editUrl);
    _form.find('input[type="submit"]').val(this.updateTitle);
    this.$dialog.call(this).find("h3").text(this.updateTitle);
    this.setMethod("put");
    this.populateForm({ project: data });

    var options = {
      success: function(responseText, status, xhr) {
        $row.replaceWith(responseText);
        _this.$dialog.call(_this).modal('hide');
        Notification.show('success', I18n.t("flash.actions.update.notice", {resource_name: _this.modelName}));
      }
    };

    // Append id value to all uniqueness validators
    $.each(window.ClientSideValidations.forms[this.$form.call(this).attr("id")].validators, function(index, element) {
      if (!element.uniqueness) return;

      $.each(element.uniqueness, function(innerIndex, innerElement) {
        innerElement.id = data.id;
      });
    });

    this.$dialog.call(_this).modal('show');
    return function() { this.makeAjaxForm(options) };
  };

  GridDialog.prototype.destroy = function(event) {
    var _this = this;
    var _event = event;

    // Get the clicked row
    var $row = $(_event.target).closest("tr");

    // Get serialized data
    var data = $row.data("serialized");

    var callback = function() {

      // Build delete url
      var deleteUrl = _this.resourceUrl + "/" + data.id;

      // Destroy the record
      $.post(deleteUrl, { _method: "delete" }, function(data, textStatus, jqXHR) {
        $row.remove();
        Notification.show('success', I18n.t("flash.actions.destroy.notice", {resource_name: _this.modelName}));
      });
    };

    new Widgets.Confirm("Confirm delete", "Are you sure you want to delete project '" + data.name + "'?", callback);
  };

  GridDialog.prototype.setMethod = function(method) {
    this.$form.call(this).find("input[name=_method]").val(method);
  };

  GridDialog.prototype.populateForm = function(data) {
    this.$form.call(this).populate(data);
  };

  GridDialog.prototype.makeAjaxForm = function(options) {
    this.$form.call(this).ajaxForm(options);
  };

  ClassRegistry.set('Widgets.Patterns.GridDialog', GridDialog);
})(jQuery, window);

$(document).ready(function() {
  $(".GridDialog").each(function() {
    new Widgets.Patterns.GridDialog(this);
  });
});
