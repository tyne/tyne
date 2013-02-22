//= require ./../support/class_registry

(function($) {
  function Confirm(headline, text, callback, callbackData) {
    var _this = this;

    var confirmModal = $(SMT['templates/cells/confirm']({ headline: headline, text: text }));

    confirmModal.find("#button_confirm").on("click", function() {
      callback(callbackData);
      confirmModal.modal('hide');
    });

    confirmModal.on("hidden", function(event) {
      $(event.target).remove();
    });

    confirmModal.modal('show');
  };

  ClassRegistry.set('Widgets.Confirm', Confirm);
})(jQuery);
