$(document).ready(function() {
  $(".issue-list").on("click", "div", function() {
    $(".issue-list .selected").removeClass("selected");

    $(this).addClass("selected");
  });

  $('[data-behaviour="issue-view"]').on("click", "button", function() {
    var view = "issue-" + $(this).data("view");

    $(".issue-list").removeClass("issue-minimal").removeClass("issue-compact").removeClass("issue-detailed")
    .addClass(view);
  });
});
