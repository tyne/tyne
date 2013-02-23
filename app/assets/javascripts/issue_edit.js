$(document).ready(function() {
  $(".btn-issue-edit").on("click", function() {
    if ($(this).data("behaviour") == 'cancel') {
      $(".edit_issue").find(':input').attr("disabled", "disabled");
      $(this).data("behaviour", "edit").text("Edit");
    } else {
      $(".edit_issue").find('[disabled="disabled"]').removeAttr("disabled");
      $(this).data("behaviour", "cancel").text("Cancel");
    }
  });
});
