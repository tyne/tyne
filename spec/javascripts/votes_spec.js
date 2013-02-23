describe('Votes', function() {
  var instance;

  beforeEach(function() {
    jQuery.fx.off = true;

    loadFixtures('cells_votes.html');
    Votes.instances = [];
    instance = Cell.findOrCreateInstance($('.Votes').get(0));
  });

  it('should define animation duration settings', function() {
    expect(Votes.fadeOutDuration).toBeDefined();
    expect(Votes.fadeInDuration).toBeDefined();
  });

  describe('#initialize', function() {
    it('should define the $voteUp property', function() {
      expect(instance.$voteUp.get(0)).toEqual(instance.$target.find('.VoteUp').get(0));
    });

    it('should define the $voteDown property', function() {
      expect(instance.$voteDown.get(0)).toEqual(instance.$target.find('.VoteDown').get(0));
    });

    it('should define the $voteUp property', function() {
      expect(instance.$totalVotes.get(0)).toEqual(instance.$target.find('.TotalVotes').get(0));
    });

    it('should call #initializeEventHandlers', function() {
      spyOn(instance, 'initializeEventHandlers');
      instance.initialize();
      expect(instance.initializeEventHandlers).wasCalled();
    });
  });

  describe('#initializeEventHandlers', function() {
    it('should bind to the vote up click', function() {
      spyOn(instance, 'onVote');
      instance.$voteUp.click();
      expect(instance.onVote).wasCalledWith(instance.$voteUp.get(0).href);
    });

    it('should bind to the vote up click', function() {
      spyOn(instance, 'onVote');
      instance.$voteDown.click();
      expect(instance.onVote).wasCalledWith(instance.$voteDown.get(0).href);
    });
  });

  describe('#onVote', function() {
    it('should return false', function() {
      spyOn(jQuery, 'post').andReturn({'done': function(fn) { }});
      expect(instance.onVote('foo')).toBeFalsy();
    });

    it('should make a post request', function() {
      spyOn(jQuery, 'post').andReturn({'done': function(fn) { }});
      instance.onVote('foo');
      expect(jQuery.post).wasCalledWith('foo');
    });

    it('should update the total amount afterwards', function() {
      var callback; // stores the callback assigned during POST request definition

      spyOn(jQuery, 'post').andReturn({'done': function(fn) { callback = fn; }});
      instance.onVote('foo');

      spyOn(instance, 'updateTotalVotes');
      callback('moreFoo');
      expect(instance.updateTotalVotes).wasCalledWith('moreFoo');
    });
  });

  describe('#updateTotalVotes', function() {
    it('should set the total votes', function() {
      instance.updateTotalVotes('123456');
      expect(instance.$totalVotes.html()).toEqual('123456');
    });
  });
});
