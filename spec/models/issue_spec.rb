require 'spec_helper'

describe Issue do
  it { should have_many :labels }

  let(:user) { User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo") }
  let(:project) { user.projects.create!(:key => "Foo", :name => "Foo") }
  let(:issue) { create(:issue, :project => project) }

  describe :votable do
    subject { issue }

    it_should_behave_like :votable
  end

  describe :description do
    it "should convert the description into markdown" do
      subject.description = "Foo"
      subject.description_markdown == "<p>Foo</p>"
    end
  end

  describe :apply_template do
    it "copies the details from an existing issue" do
      subject.project = issue.project
      subject.apply_template(issue.number)

      subject.issue_type.should == issue.issue_type
      subject.issue_priority.should == issue.issue_priority
      subject.assigned_to.should == issue.assigned_to
    end

    it "does not apply if issue has no project" do
      subject.project = nil
      subject.apply_template(issue.number)

      subject.assigned_to.should be_nil
    end

    it "does not apply if template does not exist" do
      subject.project = issue.project
      subject.apply_template(9999)

      subject.assigned_to.should be_nil
    end
  end

  describe :available_transitions do
    context "for a new ticket" do
      it "should return the current state without an action" do
        described_class.new.available_transitions.should == { "open" => nil }
      end
    end

    context "for an existing ticket" do
      before :each do
        issue.stub(:new_record?).and_return(false)
      end

      it "should return the current state and the available states" do
        issue.available_transitions.should == { "open" => nil, "wip" => :start_working, "done" => :task_is_done, "invalid" => :task_is_invalid }
      end
    end
  end

  describe :states do
    it "should be completed if state is done" do
      issue.should_not be_completed

      issue.start_working
      issue.should_not be_completed

      issue.task_is_done
      issue.should be_completed

      issue.task_is_done
      issue.should be_completed

      issue.reopen
      issue.should_not be_completed
    end

    it "should be completed if state is invalid" do
      issue.task_is_invalid
      issue.completed?.should be_true
    end
  end

  describe :number do
    it "should use the next available number in the project context" do
      max = (project.issues.maximum('number') || 0)
      issue = project.issues.create!(:summary => "Foo", :issue_type_id => 1)
      issue.number.should == max + 1
    end
  end

  describe :custom_validation do
    it "should not allow to assign users which are not in any of teams" do
      bob = User.create!(:name => "Bob", :uid => "B", :token => "Bob")

      expect do
        project.issues.create!(:summary => "Foo", :assigned_to_id => bob.id, :issue_type_id => 1)
      end.to raise_error

      expect do
        project.issues.create!(:summary => "Foo", :assigned_to_id => user.id, :issue_type_id => 1)
      end.to_not raise_error
    end
  end

  describe :activity do
    let(:sprint) { project.sprints.create!(:name => "Unnamed") }

    before :each do
      issue.sprint_id = sprint.id
      issue.save!

      sprint.start(Date.today, Date.today + 7.days)
    end

    describe :close do
      it "should create an activity change for closing an issue" do
        issue.task_is_done
        activity = sprint.activities.last
        activity.scope_change.should == issue.estimate * -1
      end
    end

    describe :reopen do
      it "should create an activity change for closing an issue" do
        issue.task_is_done
        issue.reopen
        activity = sprint.activities.last
        activity.scope_change.should == issue.estimate
      end
    end
  end

  describe :github_client do
    it "should return an instance of octokit" do
      user.github_client.should be_a Octokit::Client
    end
  end
end
