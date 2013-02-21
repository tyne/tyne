require 'spec_helper'

describe TyneCore::SprintsController do
  let(:user) do
    TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
  end

  let(:project) do
    user.projects.create!(:key => "Foo", :name => "Foo")
  end

  let(:issue) do
    project.issues.create!(:summary => "Foo", :issue_type_id => 1)
  end

  let(:sprint) do
    project.sprints.create!(:name => "Foo")
  end

  context :logged_in do
    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :index, :user => user.username, :key => project.key, :use_route => :tyne_core
      end

      it "assigns the list of all open sprints" do
        assigns(:sprints).should == project.sprints.not_running
        response.should be_success
      end
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :use_route => :tyne_core
      end

      it "should create a new sprint" do
        assigns(:sprint).name.should == 'Unnamed sprint'
        response.should be_success
      end
    end

    describe :update do
      let(:sprint) { project.sprints.create!(:name => "Foo") }

      before :each do
        put :update, :user => user.username, :key => project.key, :id => sprint.id, :sprint => { :name => "Bar" }, :use_route => :tyne_core, :format => :json
      end

      it "should create a new sprint" do
        assigns(:sprint).name.should == 'Bar'
        response.should be_success
      end
    end

    describe :destroy do
      let(:sprint) { project.sprints.create!(:name => "Foo") }

      context :success do
        before :each do
          delete :destroy, :user => user.username, :key => project.key, :id => sprint.id, :sprint => { :name => "Bar" }, :use_route => :tyne_core, :format => :json
        end

        it "should delete the sprint" do
          expect do
            project.sprints.find(sprint.id)
          end.to raise_error(ActiveRecord::RecordNotFound)
          response.should be_success
        end
      end

      context :failure do
        before :each do
          TyneCore::Sprint.any_instance.should_receive(:destroy).and_return(false)
          delete :destroy, :user => user.username, :key => project.key, :id => sprint.id, :sprint => { :name => "Bar" }, :use_route => :tyne_core, :format => :json
        end

        it "should not delete the sprint" do
          expect do
            project.sprints.find(sprint.id)
          end.to_not raise_error(ActiveRecord::RecordNotFound)
          response.should_not be_success
        end
      end
    end

    describe :reorder do
      context :success do
        before :each do
          post :reorder, :user => user.username, :key => project.key, :id => sprint.id, :issue_id => issue.id, :position => 1, :use_route => :tyne_core, :format => :json
        end

        it "should order the issue correctly in the sprint and remove from the backlog" do
          issue.reload

          issue.sprint.should == sprint
          issue.sprint_position.should == 1
          issue.position.should be_nil
          response.should be_success
        end
      end

      context :failure do
        before :each do
          TyneCore::SprintItem.any_instance.should_receive(:insert_at).and_return(false)
          post :reorder, :user => user.username, :key => project.key, :id => sprint.id, :issue_id => issue.id, :use_route => :tyne_core, :format => :json
        end

        it "should respond with an error" do
          response.should_not be_success
        end
      end
    end

    describe :start do
      before :each do
        put :start, :user => user.username, :key => project.key, :id => sprint.id, :sprint => { :start_date => Date.today, :end_date => 3.days.from_now },:use_route => :tyne_core
      end

      it "should set the status of the sprint to active and redirect to current" do
        sprint.reload

        sprint.active.should be_true
        response.should redirect_to current_sprints_path(:user => user.username, :key => project.key)
      end
    end

    describe :finish do
      before :each do
        put :finish, :user => user.username, :key => project.key, :id => sprint.id, :use_route => :tyne_core
      end

      it "should set the status of the sprint to not active and redirect back to planning" do
        sprint.reload

        sprint.active.should be_false
        sprint.finished.should_not be_nil
        response.should redirect_to sprints_path(:user => user.username, :key => project.key)
      end
    end

    describe :current do
      before :each do
        get :current, :user => user.username, :key => project.key, :use_route => :tyne_core
      end

      it "should render the correct template" do
        response.should render_template "tyne_core/sprints/current"
        response.should be_success
      end
    end
  end
end
