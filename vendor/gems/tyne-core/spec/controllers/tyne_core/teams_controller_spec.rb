require 'spec_helper'

describe TyneCore::TeamsController do
  its (:is_admin_area?) { should be_true }

  context :not_logged_in do
    it "should not allow any actions" do
      get :show, :user => "Foo", :key => "Bar", :id => 1
      response.should redirect_to login_path
    end
  end

  context :logged_in do
    let(:user) do
      user = TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
    end
    let(:project) { user.projects.create!(:key => "FOO", :name => "Foo") }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :show, :user => user.username, :key => project.key, :id => 1, :use_route => :tyne_core
      end

      it "render the correct view" do
        response.should render_template "teams/show"
      end
    end

    describe :suggest_user do
      before :each do
        TyneAuth::User.create!(:name => "Bar", :username => "Bar", :uid => "bar", :token => "bar")
        controller.stub(:require_owner).and_return(true)
        get :suggest_user, :user => user.username, :key => project.key, :id => 1, :term => "Ba", :use_route => :tyne_core, :format => :json
      end

      it "should return user that match with the term" do
        hash = JSON.parse(response.body)
        hash[0]['label'].should == "Bar"
      end
    end
  end
end
