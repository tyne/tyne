require 'spec_helper'

describe ProjectsController do
  its (:is_admin_area?) { should be_false }

  context :not_logged_in do
    it "should not allow any actions" do
      post :create
      response.should redirect_to login_path

      delete :destroy, :id => 1
      response.should redirect_to login_path

      get :github
      response.should redirect_to login_path

      post :import
      response.should redirect_to login_path
    end
  end

  context :logged_in do
    let(:user) { users(:tobscher) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :new do
      before :each do
        get :new
      end

      it "should render the new view" do
        response.should render_template "projects/new"
      end
    end

    describe :create do
      context :success do
        before :each do
          post :create, :project => { :key => "FOO", :name => "Foo" }
        end

        it "should redirect to the backlog path" do
          project = Project.find_by_key("FOO")
          response.should redirect_to backlog_path(:user => user.username, :key => project.key)
        end
      end

      context :failure do
        it "should return the error message" do
          Project.any_instance.stub(:valid?).and_return(false)
          post :create, :project => { :key => "FOO", :name => "Foo" }

          response.should_not be_success
        end
      end
    end

    describe :update do
      let(:existing) { projects(:tyne) }

      context :success do
        it "should update the record" do
          put :update, :id => existing.id, :project => { :key => "BAR" }
          Project.find_by_id(existing.id).key.should == "BAR"
        end

        it "should render the correct view" do
          put :update, :id => existing.id, :project => { :key => "BAR" }
          response.should redirect_to admin_project_path(:user => user.username, :key => "BAR")
        end

        it "should only destroy the projects for the current user" do
          project = Project.create!(:key => "BAR", :name => "Bar") do |p|
            p.user_id = 1337
          end

          expect do
            put :update, :id => project.id, :project => { :key => "BAZ" }
          end.to raise_error

          Project.find_by_id(project.id).key.should == "BAR"
        end
      end

      context :failure do
        it "should return the error message" do
          Project.any_instance.stub(:valid?).and_return(false)
          put :update, :id => existing.id, :project => { :key => "BAR" }

          response.should_not be_success
        end
      end
    end

    describe :destroy do
      let(:project) do
        user.projects.create!(:key => "FOO", :name => "Foo")
      end

      it "should destroy the record" do
        delete :destroy, :id => project.id, :format => :json
        user.projects.find_by_id(project.id).should_not be_present
      end

      it "should respond with ok" do
        delete :destroy, :id => project.id, :format => :json
        response.should be_success
      end

      it "should only destroy the projects for the current user" do
        project = Project.create!(:key => "BAR", :name => "Bar") do |p|
          p.user_id = 1337
        end

        expect do
          delete :destroy, :id => 1337, :format => :json
        end.to raise_error

        Project.find_by_id(project.id).should be_present
      end
    end

    describe :github do
      before :each do
        user.stub_chain(:github_client, :repositories).and_return(:foo)
        get :github
      end

      it "should assign a list of all github repos" do
        assigns(:repositories).should == :foo
      end

      it "should render the correct view" do
        response.should render_template "projects/github"
      end
    end

    describe :import do
      before :each do
        post :import, :name => ["Foo", "Bar"]
      end

      it "should create a project for each selected github repo" do
        Project.find_by_name("Foo").user_id.should == user.id
        Project.find_by_name("Bar").user_id.should == user.id
      end

      it "should redirect back to the index page" do
        response.should redirect_to :action => :index
      end
    end

    describe :admin do
      its (:is_admin_area?) { should be_true }

      let!(:existing) do
        user.projects.create!(:key => "FOO", :name => "Foo")
      end

      before :each do
        get :admin, :user => user.username, :key => existing.key
      end

      it "should assign a new project" do
        assigns(:project).should == existing
      end

      it "should render the correct view" do
        response.should render_template "projects/admin"
      end
    end
  end
end
