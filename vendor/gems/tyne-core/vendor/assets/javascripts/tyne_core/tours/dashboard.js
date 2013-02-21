(function($) {
  var DashboardTour = Cell.create('DashboardTour');

  DashboardTour.prototype.initialize = function() {
    var tour = new Tour({name: "Dashboard"});
    tour.addStep({
      element: ".new-project-link",
      title: "Tyne - Dashboard",
      content: "Click on 'New Project' if you'd like to create a new project.",
      placement: 'bottom'
    });

    tour.addStep({
      element: "#sidebar",
      title: "Tyne - Dashboard",
      content: "Your new project will be visible in your sidebar after you have created it.",
      placement: 'right'
    });

    tour.addStep({
      element: '.activities-anchor',
      title: "Tyne - Dashboard",
      content: "Your and your contributor's activity will be visible in the activity stream.",
      placement: 'left'
    });

    tour.start();
  };
})(jQuery);
