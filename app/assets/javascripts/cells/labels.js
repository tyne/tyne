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

      listItem.toggleClass("selected");
    });
  };
})(jQuery);
