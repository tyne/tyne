(function($) {
  var BacklogTour = Cell.create('BacklogTour');

  BacklogTour.prototype.initialize = function() {
    var tour = new Tour({name: "Backlog"});
    tour.addStep({
      element: ".new-issue-link",
      title: "Tyne - Backlog",
      content: "Click on 'Create' to create a new user story or to report an issue.",
      placement: 'bottom'
    });

    tour.addStep({
      element: "#sidebar",
      title: "Tyne - Backlog",
      content: "Use the sidebar to search, filter or sort your backlog.",
      placement: 'right'
    });

    tour.addStep({
      element: ".admin-link",
      title: "Tyne - Backlog",
      content: "Click on 'Admin' to change your project details or to add contributors.",
      placement: 'bottom'
    });

    tour.start();
  };
})(jQuery);
