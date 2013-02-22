//= require ./class_registry

(function($, exports, undefined) {
  function Cell(target) {
    this.target = target;
    this.$target = $(target);

    var features = this.$target.data('cell-features');
    this.features = features ? features.split(',') : [];
  };

  Cell.prototype.hasFeature = function(feature) {
    return 0 <= this.features.indexOf(feature);
  };

  Cell.create = function(cellName) {
    var C = function(target) {
      Cell.call(this, target);
      ClassRegistry.get(cellName).instances.push(this);
      this.initialize();
    };

    C.prototype = Object.create(Cell.prototype);
    C.prototype.initialize = function() { };
    C.instances = [];

    return ClassRegistry.set(cellName, C);
  };

  Cell.findOrCreateInstance = function(target) {
    var i,
        cellName = $(target).data('cell'),
        klass = cellName ? ClassRegistry.get(cellName) : undefined,
        instances = klass ? klass.instances : [],
        n = instances.length;

    for (i = 0; i < n; ++i) {
      if (instances[i].target == target) {
        return instances[i];
      }
    }

    return new klass(target);
  };

  Cell.initializeAll = function(target) {
    target = target || document.body;

    var i,
        $elements = $(target).find('[data-cell]'),
        n = $elements.length;

    for (i = 0; i < n; ++i) {
      Cell.findOrCreateInstance($elements.get(i));
    }
  };

  exports.Cell = Cell;
})(jQuery, window);
