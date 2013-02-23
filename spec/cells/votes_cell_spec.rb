require 'spec_helper'

describe VotesCell do
  let(:user) { User.create!(:name => 'Foo', :username => 'Foo', :uid => 'foo', :token => 'foo') }
  let(:project) { user.projects.create!(:key => 'Foo', :name => 'Foo') }
  let(:issue) { Issue.create!(:summary => 'Foo', :project_id => project.id, :issue_type_id => 1) }

  subject do
    cell(:votes)
  end

  describe '#show' do
    it 'should render the view' do
      subject.should_receive(:render)
      subject.show(issue, :upvote_path => 'foo', :downvote_path => 'bar')
    end

    describe :view do
      subject do
        issue.stub(:total_votes).and_return(55)
        render_cell :votes, :show, issue, :upvote_path => 'foo', :downvote_path => 'bar'
      end

      it 'should render an upvote link' do
        subject.should have_selector('.Votes a.VoteUp[href="foo"]')
      end

      it 'should render a downvote link' do
        subject.should have_selector('.Votes a.VoteDown[href="bar"]')
      end

      it 'should render the total votes' do
        subject.should have_selector('.Votes div.TotalVotes', :text => '55')
      end
    end
  end
end
