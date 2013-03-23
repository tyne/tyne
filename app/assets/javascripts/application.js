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
//= require_tree ./support
//= require_tree ./plugins
//= require_tree .

$(function() {
  Cell.initializeAll();

  $('textarea.growable').jtextarea();
});
