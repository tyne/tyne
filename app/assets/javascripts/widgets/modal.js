$(function() {
  $('.modal').on('shown', function () {
    $(ClientSideValidations.selectors.forms).validate();
  });
});
