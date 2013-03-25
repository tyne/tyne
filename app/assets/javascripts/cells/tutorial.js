(function ($) {
  var Tutorial = Cell.create('Tutorial');

  /**
   * Contains tutorials (name, steps) indexed by ID
   */
  Tutorial.data = {};

  Tutorial.prototype.initialize = function () {
    var i,
        id = this.$target.data('tutorial-id'),
        data = (Tutorial.data[id] ? Tutorial.data[id] : {}),
        tour = new Tour({name: data.name});

    tour._steps = data.steps;
    tour.start();
  };
}(jQuery));
