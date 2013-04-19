//= require jquery
//= require jquery.cookie
//= require jquery_ujs
//= require mousetrap
//= require jquery-ui
//= require best_in_place
//= require twitter/bootstrap
//= require twitter/bootstrap/rails/confirm
//= require rails.validations
//= require rails.validations.simple_form
//= require i18n
//= require i18n/translations
//= require mustache
//= require spectrum
//= require_tree ./support
//= require_tree ./plugins
//= require_tree ./extensions
//= require_tree .

$(function() {
  Cell.initializeAll();

  // bootstrap related
  $("a[rel=popover]").popover();
  $(".tooltipped-bottom").tooltip({placement: 'bottom'});
  $("a[rel=tooltip]").tooltip();

  // activate best-in-place
  $(".best_in_place").best_in_place();

  // support growable textareas
  $('textarea.growable').jtextarea();
  $('input[data-type="colour"]').spectrum({
    preferredFormat: "hex6",
    showButtons: false
  });
});
