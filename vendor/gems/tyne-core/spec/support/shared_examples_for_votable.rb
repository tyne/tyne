shared_examples_for :votable do
  before :each do
    subject.votes.destroy_all
  end

  describe :associations do
    it { should have_many :votes }
  end

  describe '#upvotes' do
    it 'should return the sum of all positive vote weights' do
      user = TyneAuth::User.last
      weights = [-10, 1, 2, 3]
      weights.each {|weight| subject.votes.create(:user => user, :weight => weight)}
      subject.upvotes.should == 6
    end
  end

  describe '#downvotes' do
    it 'should return the sum of all negative vote weights' do
      user = TyneAuth::User.last
      weights = [-10, -20, -30, 1]
      weights.each {|weight| subject.votes.create(:user => user, :weight => weight)}
      subject.downvotes.should == 60
    end
  end

  describe '#total_votes' do
    it 'should return the sum of all vote weights' do
      user = TyneAuth::User.last
      weights = [-10, -20, -30, 1, 2, 3]
      weights.each {|weight| subject.votes.create(:user => user, :weight => weight)}
      subject.total_votes.should == weights.sum
    end
  end

  describe '#voted?' do
    it 'should return true if the specified user already voted for the subject' do
      user = TyneAuth::User.last
      vote = subject.votes.create(:user => user, :weight => 1)
      subject.voted?(user).should be_true
    end

    it 'should return false if the specified user did not yet vote for the subject' do
      subject.voted?(TyneAuth::User.last).should be_false
    end
  end

  describe '#vote_for' do
    it 'should create a vote for the given user with the specified weight' do
      subject.vote_for(TyneAuth::User.last, 111)
      vote = subject.votes.last
      vote.user.should == TyneAuth::User.last
      vote.weight.should == 111
    end
  end

  describe '#downvote_for' do
    it 'should create a downvote for the given user' do
      subject.should_receive(:vote_for).with(TyneAuth::User.last, -1)
      subject.downvote_for(TyneAuth::User.last)
    end
  end

  describe '#upvote_for' do
    it 'should create an upvote for the given user' do
      subject.should_receive(:vote_for).with(TyneAuth::User.last, 1)
      subject.upvote_for(TyneAuth::User.last)
    end
  end
end
