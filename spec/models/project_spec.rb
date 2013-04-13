require 'spec_helper'

describe Project do
  it { should have_many :teams }
  it { should have_many :labels }

  it "should have an owner and a contributor team" do
    user = stub_model(User)
    project = user.projects.create!(:key => "FOO", :name => "Foo")
    teams = project.teams
    owners = teams.detect { |x| x.name == "Owners" && x.admin_privileges }
    owner = owners.members.detect { |x| x.user_id == user.id }
    owner.should be_present

    contributors = teams.detect { |x| x.name == "Contributors" }
    contributors.should be_present
  end

  describe :any_running do
    it "should determine wether there is a running sprint or not" do
      user = stub_model(User)
      project = user.projects.create!(:key => "FOO", :name => "Foo")
      sprint = project.sprints.create!(:name => "Foo")

      sprint.start(Date.today, 3.days.from_now)
      project.any_running?.should be_true

      sprint.finish
      project.any_running?.should be_false
    end
  end

  describe :full_name do
    it "should return the key prefixed by the username" do
      subject.user = stub_model(User, :username => "Foo")
      subject.key = "Bar"
      subject.full_name.should == "Foo/Bar"
    end
  end
end
