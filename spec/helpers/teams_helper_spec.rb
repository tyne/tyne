require 'spec_helper'

describe TeamsHelper do
  before :each do
    @john = User.create!(:name => "John", :username => "John", :uid => "j", :token => "foo")
    @bob = User.create!(:name => "Bob", :username => "Bob", :uid => "b", :token => "foo")
    @sally = User.create!(:name => "Sally", :username => "Sally", :uid => "s", :token => "foo")

    @project = @john.projects.create!(:key => "F", :name => "Foo")
  end

  describe :available_members do
    it 'should return all users which are not already part of the team' do
      owners = @project.teams.first

      available = helper.available_members(owners)
      available.should_not include @john # John automatically gets added as a owner by creating the project
      available.should include @bob
      available.should include @sally
    end
  end

  describe :team_description_for do
    it "should return the correct i18n scope" do
      team = Team.new
      team.admin_privileges = true
      helper.team_description_for(team).should == t("descriptions.teams.admin_html")

      team.admin_privileges = false
      helper.team_description_for(team).should == t("descriptions.teams.default_html")
    end
  end
end
