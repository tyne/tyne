(function () {
  $(":submit").closest("form").submit(function () {
    $(this).find(':submit').prop('disabled', true);
  });

  window.ClientSideValidations.callbacks.form.fail = function (form, eventData) {
    form.find(":submit").prop("disabled", false);
  }
}());
