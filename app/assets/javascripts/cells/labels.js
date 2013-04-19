(function($) {

  var Labels = Cell.create("Labels");

  Labels.prototype.initialize = function() {
    var _this = this;

    this.$form = _this.$target.find("form");

    _this.attachEvents();
  };

  Labels.prototype.attachEvents = function() {
    var _this = this;

    var options = {
      success: function(responseText, status, xhr) {
        _this.$target.find(".labels-list").append(responseText);
        _this.$form.populate({});
        _this.$form.find('input[name="commit"]').prop("disabled", false);
        Notification.show('success', I18n.t("flash.actions.create.notice", {resource_name: "Label"}));
      }
    };

    _this.$form.ajaxForm(options);

    _this.$target.on("click", "label", function() {
      var label = $(this);
      var listItem =  label.closest("li");
      var colour = label.data("colour");
      var textColour = "#FFFFFF";

      var red   = parseInt(colour.substr(1, 2), 16);
      var green = parseInt(colour.substr(3, 2), 16);
      var blue  = parseInt(colour.substr(5, 2), 16);

      if (Luminance.isBright(red, green, blue)) {
        textColour = "#000000";
      }

      if (listItem.is(".selected")) {
        label.css("background-color", "").css("color", colour);
      } else {
        label.css("background-color", colour).css("color", textColour);
      }
      listItem.toggleClass("selected");
    });
  };

  var LabelledForms = [".new_issue", ".edit_issue"];

  ClientSideValidations.callbacks.form.pass = function(form, eventData) {
    if (!form.is(LabelledForms.join(", "))) return;

    var labels = Labels.instances[0];
    labels.$target.find("li label").each(function(index, value) {
      var id = $(value).data("id");
      var originalId = $(value).data("present");
      var existing = !!originalId;
      var selected = $(value).closest("li").is(".selected");
      var destroy = existing && !selected;

      if (!existing && !selected) return;

      // Create hidden inputs
      var baseName = "issue[issue_labels_attributes][" + index + "]";
      var idInput = $("<input>").attr("name", baseName + "[id]").attr("type", "hidden").val(originalId);
      var labelIdInput = $("<input>").attr("name", baseName + "[label_id]").attr("type", "hidden").val(id);
      var destroyInput = $("<input>").attr("name", baseName + "[_destroy]").attr("type", "hidden").val(destroy ? "1" : "0");
      form.append(idInput);
      form.append(labelIdInput);
      form.append(destroyInput);
    });
  };
})(jQuery);
