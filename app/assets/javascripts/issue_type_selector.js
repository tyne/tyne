$(document).ready(function() {
  var selector = "select#issue_issue_type_id";
  var types = ["bug", "enhancement", "story", "feature", "task"];

  $(selector).on("change", function() {
    var _this = $(this);
    var parentContainer = $(this).closest(".centered");
    $.each(types, function(index, value) {
      parentContainer.removeClass(value);
    });

    parentContainer.addClass(_this.find("option:selected").text().toLowerCase());
  });
});
