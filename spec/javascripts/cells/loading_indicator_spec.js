describe('LoadingIndicator', function() {
  beforeEach(function() {
    loadFixtures('cells_loading_indicator.html');
    LoadingIndicator.instances = [];
  });

  describe('#initialize', function() {
    var instance;

    it("should set the target parent's CSS position to 'relative' if it's static", function() {
      expect($('#target-1').css('position')).toEqual('static');
      Cell.findOrCreateInstance($('.LoadingIndicator')[0]);
      expect($('#target-1').css('position')).toEqual('relative');
    });

    it('should adjust the icon position (centering)', function() {
      spyOn(LoadingIndicator.prototype, 'centerIcon');

      instance = Cell.findOrCreateInstance($('.LoadingIndicator')[0]);
      expect(LoadingIndicator.prototype.centerIcon).wasCalled();
    });
  });

  describe('#centerIcon', function() {
    it('should center the icon', function() {
      instance = Cell.findOrCreateInstance($('.LoadingIndicator')[0]);

      spyOn(instance.$target, 'width').andReturn(100);
      spyOn(instance.$target, 'height').andReturn(100);
      spyOn(instance.$icon, 'width').andReturn(10);
      spyOn(instance.$icon, 'height').andReturn(10);

      spyOn(instance.$icon, 'css');

      instance.centerIcon();

      expect(instance.$icon.css).wasCalledWith({'left': '45px', 'top': '45px'});
    });
  });

  describe('#addTo', function() {
    it("should do nothing if there's already a loading indicator allocated", function() {
      spyOn(LoadingIndicator, 'addedTo').andReturn(true);
      var oldHtml = $('#target-2').html();
      LoadingIndicator.addTo('#target-2');
      expect($('#target-2').html()).toEqual(oldHtml);
    });
  });

  describe('#addedTo', function() {
  });

  describe('#removeFrom', function() {
  });
});
