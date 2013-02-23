//= require ./../support/cell

(function($) {
  var LoadingIndicator = Cell.create('LoadingIndicator');

  LoadingIndicator.prototype.initialize = function() {
    var $targetParent = this.$target.parent();

    if ('static' == $targetParent.css('position')) {
      $targetParent.css('position', 'relative');
    }

    this.$icon = this.$target.find('.LoadingIndicatorIcon');

    this.centerIcon();
  };

  LoadingIndicator.prototype.centerIcon = function() {
    var width = this.$target.width(),
        height = this.$target.height(),
        iconWidth = this.$icon.width(),
        iconHeight = this.$icon.height();

    this.$icon.css({
      'left': ((width - iconWidth) / 2) + 'px',
      'top': ((height - iconHeight) / 2) + 'px'
    });
  };

  LoadingIndicator.addTo = function(loadedTarget) {
    if (!LoadingIndicator.addedTo(loadedTarget)) {
      var $loadedTarget = $(loadedTarget),
          html = SMT['templates/cells/loading_indicator']();

      $loadedTarget.first().append(html);
      Cell.findOrCreateInstance($loadedTarget.first().find('[data-cell="LoadingIndicator"]')[0]);
    }
  };

  LoadingIndicator.addedTo = function(loadedTarget) {
    var i,
        $loadedTarget = $(loadedTarget),
        instances = LoadingIndicator.instances,
        n = instances.length;

    for (i = 0; i < n; ++i) {
      if (instances[i].target.parentNode == $loadedTarget[0]) {
        return true;
      }
    }

    return false;
  };

  LoadingIndicator.removeFrom = function(loadedTarget) {
    var i,
        $loadedTarget = $(loadedTarget),
        instances = LoadingIndicator.instances,
        n = instances.length;

    for (i = 0; i < n; ++i) {
      if (instances[i].target.parentNode == $loadedTarget[0]) {
        instances[i].$target.remove();
        instances.splice(i, 1);
        return;
      }
    }
  };

})(jQuery);
