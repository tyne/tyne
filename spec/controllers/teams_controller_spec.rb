require 'spec_helper'

describe TeamsController do
  its (:is_admin_area?) { should be_true }

  context :private_project do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:bluffr) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :privacy do
      it "should respond with 404 if user has no access to a private project" do
        get :show, :user => user.username, :key => project.key, :id => 1337
        response.status.should == 404

        get :suggest_user, :user => user.username, :key => project.key, :id => 1337
        response.status.should == 404
      end
    end
  end

  context :not_logged_in do
    it "should not allow any actions" do
      get :show, :user => "Foo", :key => "Bar", :id => 1
      response.status.should == 404
    end
  end

  context :logged_in do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:tyne) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :show, :user => user.username, :key => project.key, :id => project.teams.first.id
      end

      it "render the correct view" do
        response.should render_template "teams/show"
      end
    end

    describe :suggest_user do
      before :each do
        User.create!(:name => "Bar", :username => "Bar", :uid => "bar", :token => "bar")
        controller.stub(:require_owner)
        get :suggest_user, :user => user.username, :key => project.key, :id => project.teams.first.id, :term => "Ba", :format => :json
      end

      it "should return user that match with the term" do
        hash = JSON.parse(response.body)
        hash.last['label'].should == "Bar"
      end
    end
  end
end
