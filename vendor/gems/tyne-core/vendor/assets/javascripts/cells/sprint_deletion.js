(function($) {
  var SprintDeletion = Cell.create('SprintDeletion');

  SprintDeletion.prototype.initialize = function() {
    this.$button = this.$target.find('.delete-sprint');
    this.$dateRange = this.$target.find('.date-range');

    this.initializeEventHandlers();
  };

  SprintDeletion.prototype.initializeEventHandlers = function() {
    var _this = this;

    var dateOptions = {
      presetRanges: [
        { text: '1 Week', dateStart: 'Today', dateEnd: 'Today+7'},
        { text: '2 Weeks', dateStart: 'Today', dateEnd: 'Today+14'},
        { text: '4 Weeks', dateStart: 'Today', dateEnd: 'Today+28'},
      ],
      presets: {
        dateRange: 'Date Range'
      }
    };

    // this.$dateRange.daterangepicker(dateOptions);
    this.$button.on('ajax:success', function() { return _this.onDestroy(); });
  };

  SprintDeletion.prototype.onDestroy = function(url) {
    var _this = this;

    _this.$target.remove();

    return false;
  };
})(jQuery);
