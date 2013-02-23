(function($) {
  var Votes = Cell.create('Votes');

  Votes.fadeOutDuration = 125;
  Votes.fadeInDuration = 125;

  Votes.prototype.initialize = function() {
    this.$voteUp = this.$target.find('.VoteUp');
    this.$voteDown = this.$target.find('.VoteDown');
    this.$totalVotes = this.$target.find('.TotalVotes');

    this.initializeEventHandlers();
  };

  Votes.prototype.initializeEventHandlers = function() {
    var _this = this;

    this.$voteUp.on('click', function() { return _this.onVote(this.href); });
    this.$voteDown.on('click', function() { return _this.onVote(this.href); });
  };

  Votes.prototype.onVote = function(url) {
    var _this = this;

    $.post(url).done(function(data) {
      _this.updateTotalVotes(data);
    });

    return false;
  };

  Votes.prototype.updateTotalVotes = function(totalVotes) {
    var _this = this;

    this.$totalVotes.fadeOut(Votes.fadeOutDuration, function() {
      _this.$totalVotes.html(totalVotes);
      _this.$totalVotes.fadeIn(Votes.fadeInDuration);
    });
  };
})(jQuery);
