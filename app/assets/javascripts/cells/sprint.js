(function($) {
  var Sprint = Cell.create('Sprint');


  Sprint.prototype.initialize = function() {
    this.url = this.$target.data('url');

    this.initializeEventHandlers();
  };

  Sprint.prototype.initializeEventHandlers = function() {
    var _this = this;

    this.$target.on('click', function() { return _this.onCreate(); });
  };

  Sprint.prototype.onCreate = function(url) {
    var _this = this;

    options = {
      type: "POST",
      success: function(data, textStatus, jqXHR) {
        new SprintDeletion($(data).insertBefore(_this.$target));
        IssueOrdering.initialize();
      }
    }

    $.ajax(url, options);

    return false;
  };
})(jQuery);
