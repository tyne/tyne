describe('ClassRegistry', function() {
  beforeEach(function() {
    ClassRegistry.storage = {};
  });

  describe('#exists', function() {
    it('should return false for non-existing classes', function() {
      expect(ClassRegistry.exists('Foo.Bar')).toBeFalsy();
    });

    it('should return true for existing classes', function() {
      ClassRegistry.storage = {'Foo': {'Bar': function() { }}};
      expect(ClassRegistry.exists('Foo.Bar')).toBeTruthy();
    });
  });

  describe('#get', function() {
    it('should return an existing class', function() {
      var stub = function() { };
      ClassRegistry.storage = {'Foo': {'Bar': stub}}
      expect(ClassRegistry.get('Foo.Bar')).toEqual(stub);
    });

    it('should return nothing in case of a non-existing class', function() {
      expect(typeof(ClassRegistry.get('Foo.Bar'))).toEqual('undefined');
    });
  });

  describe('#set', function() {
    it('should set the class using the specified namespace', function() {
      var stub = function() { };
      ClassRegistry.set('Foo.Bar', stub);
      expect(ClassRegistry.storage.Foo.Bar).toEqual(stub);
    });
  });
});
