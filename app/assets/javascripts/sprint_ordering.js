$(function() {
  var IssueOrdering = {
    initialize: function() {
      $(".backlog-sortable").sortable({
        connectWith: ".backlog-connected",
        placeholder: "backlog-placeholder-element",
        update: function(event, ui) {
          var list = ui.item.parent();
          var items = list.find("li");
          var newIndex = items.index(ui.item) + 1;

          var url = list.data("reorder-url");
          var options = {
            type: "POST",
            data: {
              issue_id: ui.item.data("id"),
              position: newIndex
            }
          };

          $.ajax(url, options);
        },
        receive: function(event, ui) {
          var senderList = ui.sender;
          var senderCount = senderList.find("li").length;
          var receiverList = ui.item.closest("ul");
          var receiverCount = receiverList.find("li").length;

          senderList.closest("div").find(".issue-count").text(I18n.t("misc.issue", { count: senderCount }));
          receiverList.closest("div").find(".issue-count").text(I18n.t("misc.issue", { count: receiverCount }));

          receiverCount == 0 ? IssueOrdering.disable(receiverList) : IssueOrdering.enable(receiverList)
          senderCount == 0 ? IssueOrdering.disable(senderList) : IssueOrdering.enable(senderList)
      }}).disableSelection();
    },
    disable: function(list) {
      var button = list.parent().find(".start-sprint");
      if (button) button.attr("disabled", "disabled").attr("title", I18n.t("sprints.zero_issues"));
    },
    enable: function(list) {
      var button = list.parent().find(".start-sprint");
      if (button && !button.is('[data-running="true"]')) button.removeAttr("disabled").removeAttr("title");
    }
  }

  IssueOrdering.initialize();

  window.IssueOrdering = IssueOrdering;
});
