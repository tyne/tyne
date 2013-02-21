require 'spec_helper'

describe TyneCore::IssuesController do
  context :logged_in do
    let(:user) do
      TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
    end

    let(:project) do
      user.projects.create!(:key => "Foo", :name => "Foo")
    end

    let(:issue) do
      TyneCore::Issue.create!(:summary => "Foo", :project_id => project.id, :issue_type_id => 1)
    end

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      it "should assign the list of the issues reported by the user" do
        user.reported_issues.create!(:summary => "FOO", :description => "Foo", :issue_type_id => 1) do |issue|
          issue.project_id = project.id
        end

        get :index, :user => user.username, :key => project.key

        assigns(:issues).should == project.issues.order("created_at ASC").limit(25).offset(0)
      end

      it "should apply a filter when given" do
        user.reported_issues.create!(:summary => "FOO", :description => "Foo", :issue_type_id => 1) do |issue|
          issue.project_id = project.id
        end

        get :index, :user => user.username, :key => project.key, :filter => { "issue_type_id" => ["1"] }

        assigns(:issues).should =~ project.issues.where(:issue_type_id => [1]).order("created_at ASC").limit(25).offset(0)
      end

      it "should apply sort options when given" do
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'created_at', :order => 'desc' }

        user.reported_issues.create!(:summary => "FOO", :description => "Foo", :issue_type_id => 1) do |issue|
          issue.project_id = project.id
        end
        assigns(:issues).should == project.issues.order("created_at DESC").limit(25).offset(0)

        # Fallback for field
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'foo', :order => 'asc' }
        assigns(:issues).should == project.issues.order("id ASC").limit(25).offset(0)

        # Fallback for order
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'created_at', :order => 'foo' }
        assigns(:issues).should == project.issues.order("created_at ASC").limit(25).offset(0)

        # Custom sorting
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'issue_type', :order => 'ASC' }
        assigns(:issues).should == project.issues.joins(:issue_type).order("tyne_core_issue_types.name ASC").limit(25).offset(0)

        # Session
        get :index, :user => user.username, :key => project.key
        assigns(:issues).should == project.issues.joins(:issue_type).order("tyne_core_issue_types.name ASC").limit(25).offset(0)
      end

      it "render the correct view" do
        get :index, :user => user.username, :key => project.key

        response.should render_template "issues/index"
      end
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :issue => { :summary => "Foo", :description => "Bar", :project_id => project.id, :issue_type_id => 1 }
      end

      it "should create a new issue" do
        TyneCore::Issue.find_by_summary("Foo").reported_by.should == user
      end
    end

    describe :new do
      before :each do
        get :new, :user => user.username, :key => project.key
      end

      it "should render the correct view" do
        response.should render_template 'issues/new'
      end
    end

    describe :edit do
      before :each do
        get :edit, :user => user.username, :key => project.key, :id => issue.number
      end

      it "should render the correct view" do
        response.should render_template 'issues/edit'
      end
    end

    describe :update do
      before :each do
        put :update, :user => user.username, :key => project.key, :id => issue.number, :issue => { :summary => 'Bar' }
      end

      it "should update the issue" do
        issue.class.find_by_id(issue.id).summary.should == 'Bar'
      end
    end

    describe :assign_to_me do
      before :each do
        post :assign_to_me, :user => user.username, :key => project.key, :id => issue.number
      end

      it "should assign the issue to the current user" do
        issue.class.find_by_id(issue.id).assigned_to.should == user
      end
    end

    describe :workflow do
      context 'when a valid transition is given' do
        before :each do
          get :workflow, :user => user.username, :key => project.key, :id => issue.number, :transition => 'task_is_done'
        end

        it "should run the transition" do
          issue.class.find_by_id(issue.id).should be_completed
        end
      end

      context 'when an invalid transition is given' do
        before :each do
          get :workflow, :user => user.username, :key => project.key, :id => issue.number, :transition => 'foo'
        end

        it "should not run the transition" do
          issue.class.find_by_id(issue.id).should_not be_completed
          response.should_not be_success
        end
      end
    end

    describe :show do
      before :each do
        get :show, :user => user.username, :key => project.key, :id => issue.number
      end

      it "should render the correct view" do
        assigns(:issue).should == issue
        response.should render_template "issues/show"
      end
    end

    describe :dialog do
      before :each do
        get :dialog, :user => user.username, :key => project.key, :format => :pjax
      end

      it "should render the correct view" do
        response.should render_template "issues/dialog"
      end
    end

    describe :reorder do
      it "should reorder the issue in the sprint" do
        put :reorder, :user => user.username, :key => project.key, :issue_id => issue.id, :position => 1

        issue.reload

        issue.sprint.should be_nil
        issue.position.should == 1

        response.should be_success
      end

      it "should respond with an error if the issue cannot be reordered" do
        TyneCore::BacklogItem.any_instance.should_receive(:insert_at).and_return(false)

        put :reorder, :user => user.username, :key => project.key, :issue_id => issue.id, :position => 1

        response.should_not be_success
      end
    end

    context :votes do
      before(:each) { issue.votes.destroy_all }

      describe '#upvote' do
        it 'should vote the issue up by 1' do
          expect {
            post :upvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number
          }.to change { issue.total_votes }.by(1)
        end

        it 'should not allow multiple votes by the same user' do
          expect {
            2.times { post :upvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number }
          }.to change { issue.total_votes }.by(1)
        end

        it 'should allow a user to take back, or invert his vote' do
          issue.downvote_for(user)

          expect {
            3.times { post :upvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number }
          }.to change { issue.total_votes }.by(2)
        end

        it 'should return the total votes' do
          post :upvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number
          response.body.should == "1"
        end
      end

      describe '#downvote' do
        it 'should vote the issue down by 1' do
          expect {
            post :downvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number
          }.to change { issue.total_votes }.by(-1)
        end

        it 'should not allow multiple votes by the same user' do
          expect {
            2.times { post :downvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number }
          }.to change { issue.total_votes }.by(-1)
        end

        it 'should allow a user to take back, or invert his vote' do
          issue.upvote_for(user)

          expect {
            3.times { post :downvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number }
          }.to change { issue.total_votes }.by(-2)
        end

        it 'should return the total votes' do
          post :downvote, :use_route => :tyne_core, :user => user.username, :key => project.key, :id => issue.number
          response.body.should == "-1"
        end
      end
    end
  end
end
