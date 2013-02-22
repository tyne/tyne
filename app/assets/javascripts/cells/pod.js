//= require ./../support/cell

(function($) {
  var Pod = Cell.create('Pod');

  Pod.expandDuration = 100;
  Pod.collapseDuration = 100;

  Pod.prototype.initialize = function() {
    this.$title = this.$target.find('> .PodTitle');
    this.$content = this.$target.find('> .PodContent');

    if (this.hasFeature('collapsable')) {
      this.initializeCollapsable();
    }
  };

  Pod.prototype.initializeCollapsable = function() {
    var _this = this;

    this.$title.on("click", function() { _this.onToggleCollapseExpand(); });
  };

  Pod.prototype.collapse = function() {
    this.$title.removeClass("expanded").addClass("collapsed");
    this.$content.hide(Pod.collapseDuration);
  };

  Pod.prototype.collapsed = function() {
    return this.$content.is(':hidden');
  };

  Pod.prototype.expand = function() {
    this.$title.removeClass("collapsed").addClass("expanded");
    this.$content.show(Pod.expandDuration);
  };

  Pod.prototype.onToggleCollapseExpand = function() {
    if (this.collapsed()) {
      this.expand();
    } else {
      this.collapse();
    }
  };
})(jQuery);
