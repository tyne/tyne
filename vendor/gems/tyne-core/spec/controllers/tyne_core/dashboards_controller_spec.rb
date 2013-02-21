require 'spec_helper'

describe TyneCore::DashboardsController do
  before(:each) { @routes = TyneCore::Engine.routes }

  context :not_logged_in do
    it "should not allow any actions" do
      get :index, :use_route => :tyne_core
      response.should redirect_to login_path
    end
  end

  context :logged_in do
    let(:user) do
      user = TyneAuth::User.create!(:name => "Foo", :uid => "foo", :token => "foo")
    end

    before :each do
      controller.stub(:current_user).and_return(user)
    end


    describe :index do
      before :each do
        get :index, :use_route => :tyne_core
      end

      it "should assign the list of the user's projects" do
        user.projects.create!(:key => "FOO", :name => "Foo")
        assigns(:accessible_projects).should == user.accessible_projects
      end

      it "render the correct view" do
        response.should render_template "dashboards/index"
      end
    end
  end
end
