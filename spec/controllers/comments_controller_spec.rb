require 'spec_helper'

describe CommentsController do
  context :private_project do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:bluffr) }
    let(:issue) { issues(:qux) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :privacy do
      it "should respond with 404 if user has no access to a private project" do
        post :create, :user => user.username, :key => project.key, :issue_id => issue.number, :comment => { :message => "Foo" }, :format => :pjax

        response.status.should == 404
      end
    end
  end

  context :logged_in do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:tyne) }
    let(:issue) { issues(:foo) }

    its (:is_admin_area?) { should be_false }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :issue_id => issue.number, :comment => { :message => "Foo" }, :format => :pjax
      end

      it "should render the comment view" do
        response.should render_template "comments/_comment"
      end
    end
  end
end
