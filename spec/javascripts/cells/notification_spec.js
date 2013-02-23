describe('Notification', function() {
  var instance;

  beforeEach(function() {
    jQuery.fx.off = true;

    loadFixtures('cells_notification.html');
    Notification.instances = [];
    instance = Cell.findOrCreateInstance($('[data-cell="Notification"]').get(0));
  });

  describe('#initialize', function() {
    it('should define the "initialClassName" property', function() {
      expect(instance.initialClassName).toEqual(instance.target.className);
    });

    it('should define the "$content" property', function() {
      expect(instance.$content).toBeDefined();
    });

    it('should initialize the event handlers', function() {
      spyOn(instance, 'initializeEventHandlers');
      instance.initialize();
      expect(instance.initializeEventHandlers).wasCalled();
    });
  });

  describe('#initializeEventHandlers', function() {
    beforeEach(function() {
      $(window).off();
      instance.initializeEventHandlers();
    });

    it('should bind the showNotification event', function() {
      spyOn(instance, 'show');
      $(window).trigger('showNotification', {'classification': 'foo', 'message': 'bar'});
      expect(instance.show).wasCalledWith('foo', 'bar');
    });

    it('should bind the hideNotification event', function() {
      spyOn(instance, 'hide');
      $(window).trigger('hideNotification');
      expect(instance.hide).wasCalled();
    });
  });

  describe('#show', function() {
    it('should append the classification to the CSS class name', function() {
      instance.show('warning', 'Foo Bar');
      expect(instance.$target.hasClass('warning')).toBeTruthy();
    });

    it('should reset the currently appended CSS class name up front', function() {
      instance.show('warning', 'Foo Bar');
      instance.show('error', 'More Foo Bar');
      expect(instance.$target.hasClass('warning')).toBeFalsy();
    });

    it('should show the notification container', function() {
      instance.show('warning', 'Foo Bar');
      expect(instance.shown()).toBeTruthy();
    });

    it('should set the notification message', function() {
      instance.show('warning', 'Mega Foo');
      expect(instance.$content.html()).toEqual('Mega Foo');
    });

    it("should expand to the '$content' outer height", function() {
      instance.show('warning', 'Foo Bar<br />More Foo');
      expect(instance.$target.height()).toEqual(instance.$content.outerHeight());
    });

    it('should hide automatically after the specified interval', function() {
      spyOn(window, 'setTimeout');
      instance.show('warning', 'Foo Bar');

      expect(window.setTimeout.argsForCall[0][1]).toEqual(Notification.hideAfter);

      spyOn(instance, 'hide');
      window.setTimeout.argsForCall[0][0]();
      expect(instance.hide).wasCalled();
    });

    describe('when a notification is shown', function() {
      it('should hide the current notification before showing the next', function() {
        instance.show('warning', 'Foo Bar');
        spyOn(instance, 'hide');
        instance.show('error', 'More Foo Bar');
        expect(instance.hide).wasCalled();
      });
    });
  });

  describe('#shown', function() {
    it("should verify the $target's current 'display' value", function() {
      spyOn(instance.$target, 'css').andCallThrough();
      instance.shown();
      expect(instance.$target.css).wasCalledWith('display');
    });

    it("should return true if the 'display' value equals 'block'", function() {
      spyOn(instance.$target, 'css').andReturn('block');
      expect(instance.shown()).toBeTruthy();
    });

    it("should return true if the 'display' value does not equal 'block'", function() {
      spyOn(instance.$target, 'css').andReturn('none');
      expect(instance.shown()).toBeFalsy();
    });
  });

  describe('#hide', function() {
    it('should hide the notification', function() {
      instance.show('warning', 'Foo Bar');
      instance.hide();
      expect(instance.shown()).toBeFalsy();
    });
  });

  describe('static #show', function() {
    it("should trigger the 'showNotification' event", function() {
      var stub = {'callback': function(a, b) {}};
      $(window).on('showNotification', function(eventObject, data) { stub.callback(data.classification, data.message); });
      spyOn(stub, 'callback');
      Notification.show('foo', 'bar');
      expect(stub.callback).wasCalledWith('foo', 'bar');
    });
  });

  describe('static #hide', function() {
    it("should trigger the 'hideNotification' event", function() {
      var stub = {'callback': function() {}};
      $(window).on('hideNotification', function() { stub.callback(); });
      spyOn(stub, 'callback');
      Notification.hide();
      expect(stub.callback).wasCalled();
    });
  });
});
