describe('Cell', function() {

  beforeEach(function() {
    loadFixtures('support_cell.html');
  });

  describe('#constructor', function() {
    var instance;

    beforeEach(function() {
      instance = new Cell('foo');
    });

    it('should define the "target" property', function() {
      expect(instance.target).toEqual('foo');
    });

    it('should define the "$target" property', function() {
      expect(instance.$target).toBeDefined();
    });

    it('should define the "features" property', function() {
      expect(instance.features).toBeDefined();
    });
  });

  describe('#create', function() {
    var cellType;

    beforeEach(function() {
      cellType = Cell.create('Foo');
    });

    it('should return a basic cell', function() {
      expect(cellType.instances).toBeDefined();
    });

    describe('basic cell', function() {
      it('should register the cell in the global namespace', function() {
        expect(window.Foo).toBeDefined();
      });

      it('should define the "target" property for instances', function() {
        var instance = new cellType('fooBar');
        expect(instance.target).toBeDefined();
        expect(instance.$target).toBeDefined();
      });

      it('should define the "$target" property for instances', function() {
        var instance = new cellType('fooBar');
        expect(instance.$target).toBeDefined();
      });

      it('should define the "features" property for instances', function() {
        var instance = new cellType('fooBar');
        expect(instance.features).toBeDefined();
      });

      it('should add instances to the "instances" array during construction', function() {
        expect(cellType.instances).toEqual([]);
        var instance = new cellType('fooBar');
        expect(cellType.instances).toEqual([instance]);
      });

      it('should call the initialize method during construction', function() {
        spyOn(cellType.prototype, 'initialize');
        var instance = new cellType('fooBar');
        expect(cellType.prototype.initialize).wasCalled();
      });
    });
  });

  describe('#hasFeature', function() {
    var instance;

    beforeEach(function() {
      Cell.create('Foo');
      instance = Cell.findOrCreateInstance($('[data-cell="Foo"]')[0]);
    });

    it('should return true if the feature is requested', function() {
      instance.features = ['foo'];
      expect(instance.hasFeature('foo')).toBeTruthy();
    });

    it('should return false if the feature is not requested', function() {
      instance.features = [];
      expect(instance.hasFeature('foo')).toBeFalsy();
    });
  });

  describe('#findOrCreateInstance', function() {
    it('should create a new instance if none exists', function() {
      Cell.create('Foo');
      var $foos = $('[data-cell="Foo"]');

      spyOn(Foo.prototype, 'initialize');
      Cell.findOrCreateInstance($foos.get(0));
      expect(Foo.prototype.initialize).wasCalled();
    });

    it('should not create a new instance if one exists', function() {
      Cell.create('Foo');
      var $foos = $('[data-cell="Foo"]');
      Cell.findOrCreateInstance($foos.get(0));

      spyOn(Foo.prototype, 'initialize');
      Cell.findOrCreateInstance($foos.get(0));
      expect(Foo.prototype.initialize).wasNotCalled();
    });
  });

  describe('#initializeAll', function() {
    it('should initialize all cells if no target given', function() {
      Cell.create('Foo');
      Cell.initializeAll();
      expect(Foo.instances.length).toEqual(3);
    });

    it('should initialize all cells within the specified tree', function() {
      Cell.create('Foo');
      Cell.initializeAll($('#nested-cells').get(0));
      expect(Foo.instances.length).toEqual(2);
    });

    it('should respect idempotency of instance creation', function() {
      Cell.create('Foo');
      Cell.initializeAll();
      Cell.initializeAll();
      expect(Foo.instances.length).toEqual(3);
    });
  });
});
