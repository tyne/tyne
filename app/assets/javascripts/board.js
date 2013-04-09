$(function() {
  var Board = {
    initialize: function() {
      $( ".sortable" ).sortable({
        connectWith: ".sortable",
        placeholder: "board-placeholder-element"
      }).disableSelection();
    }
  }

  Board.initialize();

  window.Board = Board;
});
