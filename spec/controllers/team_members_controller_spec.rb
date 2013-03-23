require 'spec_helper'

describe TeamMembersController do
  its (:is_admin_area?) { should be_true }

  context :private_project do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:bluffr) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :privacy do
      it "should respond with 404 if user has no access to a private project" do
        post :create, :user => user.username, :key => project.key, :team_id => 1337
        response.status.should == 404

        delete :destroy, :user => user.username, :key => project.key, :team_id => 1337, :id => 1337
        response.status.should == 404
      end
    end
  end

  context :not_logged_in do
    it "should not allow any actions" do
      post :create, :user => "Foo", :key => "Bar", :team_id => 1, :team_member => {}
      response.status.should == 404
    end
  end

  context :logged_in do
    let!(:user) do
      User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
    end
    let!(:bob) do
      User.create!(:name => "Bob", :username => "Bob", :uid => "bob", :token => "bob")
    end
    let(:project) { user.projects.create!(:key => "FOO", :name => "Foo") }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :team_id => project.teams.first.id, :team_member => { :user_id => bob.id }
      end

      it "redirect to the team overview" do
        response.should redirect_to team_path(:user => user.username, :key => project.key, :id => project.teams.first.id)
      end
    end

    describe :destroy do
      before :each do
        member = project.teams.first.members.build(:user_id => bob.id)
        member.save!
      end

      it "should remove the user from the team and redirect" do
        delete :destroy, :user => user.username, :key => project.key, :team_id => project.teams.first.id, :id => project.teams.first.members.last.id
        response.should redirect_to team_path(:user => user.username, :key => project.key, :id => project.teams.first.id)

        project.teams.first.members.count.should == 1
      end

      it "shoudl not remove the user and redirect" do
        delete :destroy, :user => user.username, :key => project.key, :team_id => project.teams.first.id, :id => project.teams.first.members.first.id
        response.should redirect_to team_path(:user => user.username, :key => project.key, :id => project.teams.first.id)

        project.teams.first.members.count.should == 2
      end
    end
  end
end
