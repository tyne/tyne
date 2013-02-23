(function($) {

  var Comment = Cell.create("Comment");

  Comment.prototype.initialize = function() {
    var _this = this;

    _this.attachEvents();
  };

  Comment.prototype.attachEvents = function() {
    var _this = this;

    var options = {
      success: function(responseText, status, xhr) {
        _this.$target.parent().find(".comments").append(responseText);
        _this.$target.populate({});
        _this.$target.find('input[name="commit"]').removeAttr("disabled");
        Notification.show('success', I18n.t("flash.actions.create.notice", {resource_name: "Comment"}));
      }
    };

    _this.$target.on("submit", function() {
      _this.$target.find('input[name="commit"]').attr("disabled", "disabled");
    });

    _this.$target.ajaxForm(options);
  };
})(jQuery);
