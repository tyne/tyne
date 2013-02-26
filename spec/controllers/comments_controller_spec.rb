require 'spec_helper'

describe CommentsController do
  fixtures :projects, :users, :issues

  let(:user) { users(:tobscher) }
  let(:project) { projects(:tyne) }
  let(:issue) { issues(:foo) }

  its (:is_admin_area?) { should be_false }

  context :logged_in do
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
