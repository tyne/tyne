$(function() {
  var Board = {
    initialize: function() {
      $( ".sortable" ).sortable();

      $( ".work-item" ).draggable({
        revert: "invalid",
        revertDuration: 0,
        connectToSortable: ".sortable"
      });
    }
  }

  Board.initialize();

  window.Board = Board;
});
