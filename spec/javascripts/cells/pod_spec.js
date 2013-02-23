describe('Pod', function() {
  var instance;

  beforeEach(function() {
    jQuery.fx.off = true;

    loadFixtures('cells_pod.html');
    Pod.instances = [];
    instance = Cell.findOrCreateInstance($('[data-cell="Pod"]')[0]);
  });

  describe('settings', function() {
    it('should define "collapseDuration"', function() {
      expect(Pod.collapseDuration).toBeDefined();
    });

    it('should define "expandDuration"', function() {
      expect(Pod.expandDuration).toBeDefined();
    });
  });

  describe('#initialize', function() {
    it('should define the "$title" property', function() {
      expect(instance.$title).toBeDefined();
    });

    it('should define the "$content" property', function() {
      expect(instance.$content).toBeDefined();
    });

    describe('collapsable feature', function() {
      beforeEach(function() {
        spyOn(instance, 'initializeCollapsable');
      });

      it('should be initialized if requested', function() {
        spyOn(instance, 'hasFeature').andReturn(true);
        instance.initialize();
        expect(instance.initializeCollapsable).wasCalled();
      });

      it('should not be initialized if not requested', function() {
        spyOn(instance, 'hasFeature').andReturn(false);
        instance.initialize();
        expect(instance.initializeCollapsable).wasNotCalled();
      });
    });
  });

  describe('collapsable feature', function() {
    beforeEach(function() {
      if (!instance.hasFeature('collapsable')) {
        instance.features.push('collapsable');
      }
    });

    describe('#initializeCollapsable', function() {
      it('should bind the click event on "$title"', function() {
        spyOn(instance, 'onToggleCollapseExpand');
        instance.$title.trigger('click');
        expect(instance.onToggleCollapseExpand).wasCalled();
      });
    });

    describe('#collapse', function() {
      it('should modify the $title className accordingly', function() {
        instance.collapse();
        expect(instance.$title.hasClass('expanded')).toBeFalsy();
        expect(instance.$title.hasClass('collapsed')).toBeTruthy();
      });

      it('should call hide with a defined duration', function() {
        spyOn(instance.$content, 'hide');
        instance.collapse();
        expect(instance.$content.hide).wasCalledWith(Pod.collapseDuration);
      });
    });

    describe('#collapsed', function() {
      it('should return false if expanded', function() {
        instance.expand();
        expect(instance.collapsed()).toBeFalsy();
      });

      it('should return true if collapsed', function() {
        instance.collapse();
        expect(instance.collapsed()).toBeTruthy();
      });
    });

    describe('#expand', function() {
      it('should modify the $title className accordingly', function() {
        instance.expand();
        expect(instance.$title.hasClass('collapsed')).toBeFalsy();
        expect(instance.$title.hasClass('expanded')).toBeTruthy();
      });

      it('should call show with a defined duration', function() {
        spyOn(instance.$content, 'show');
        instance.expand();
        expect(instance.$content.show).wasCalledWith(Pod.expandDuration);
      });
    });
  });
});
