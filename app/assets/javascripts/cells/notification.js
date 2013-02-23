//= require ./../support/cell

(function($) {
  var Notification = Cell.create('Notification');

  Notification.fadeInDuration = 250;
  Notification.fadeOutDuration = 250;
  Notification.hideAfter = 5000;

  Notification.prototype.initialize = function() {
    this.initialClassName = this.target.className;
    this.$layer = this.$target.find('.NotificationLayer');
    this.$content = this.$target.find('.NotificationContent');

    this.initializeEventHandlers();
    this.hide();
  };

  Notification.prototype.initializeEventHandlers = function() {
    var _this = this;

    $(window).on('showNotification', function(eventObject, data) {
      _this.show(data.classification, data.message);
    });

    $(window).on('hideNotification', function(eventObject) {
      _this.hide();
    });
  };

  Notification.prototype.show = function(classification, message) {
    var _this = this;

    if (this.shown()) {
      this.hide(function() {
        _this.show(classification, message);
      });
    } else {
      this.target.className = this.initialClassName;
      this.$target.addClass(classification);
      this.$target.css({'height': '0px', 'display': 'block'});
      this.$content.html(message);

      var outerContentHeight = this.$content.outerHeight();

      this.$target.animate({'height': outerContentHeight}, {
        'duration': Notification.fadeInDuration,
        'complete': function() {
          setTimeout(function() { _this.hide() }, Notification.hideAfter);
        }
      });
    }
  };

  Notification.prototype.shown = function() {
    return 'block' == this.$target.css('display');
  };

  Notification.prototype.hide = function(callback) {
    callback = callback || function() { };

    if (this.shown()) {
      var _this = this;

      this.$target.animate({'height': '0px'}, {
        'duration': Notification.fadeOutDuration,
        'complete': function() {
          _this.$target.css({'display': 'none'});
          callback();
        }
      });
    }
  };

  Notification.show = function(classification, message) {
    $(window).trigger('showNotification', {'classification': classification, 'message': message});
  };

  Notification.hide = function() {
    $(window).trigger('hideNotification');
  };
})(jQuery);
