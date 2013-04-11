$(function() {
  var TransitionMap = {
    todo: {
      wip: "stop_working",
      invalid: "reopen",
      done: "reopen"
    },
    progress: {
      open: "start_working",
      reopened: "start_working"
    },
    done: {
      open: "task_is_done",
      reopened: "task_is_done",
      wip: "task_is_done"
    }
  }

  var TransitionHelper = {
    getTransition: function(previousState, targetState) {
      return TransitionMap[targetState][previousState];
    }
  }

  var Board = {
    initialize: function() {
      $('.board[data-collab="true"] .sortable').sortable({
        connectWith: ".sortable",
        placeholder: "board-placeholder-element",
        receive: function(event, ui) {
          var previousState = $(ui.item).data("state");
          var targetState = $(event.target).data("state");
          var transitionPath = $(ui.item).data("workflow-path");
          var transitionName = TransitionHelper.getTransition(previousState, targetState);

          if (typeof transitionName === 'undefined') $(ui.sender).sortable("cancel");

          var options = {
            data: {
              transition: transitionName
            },
            success: function(data, textStatus, jqXHR) {
              $(ui.item).data("state", data.state);
            }
          };

          $.ajax(transitionPath, options);
        }
      }).disableSelection();
    }
  }

  Board.initialize();

  window.Board = Board;
});
