require 'spec_helper'

describe CommentsController do
  its (:is_admin_area?) { should be_false }

  let(:user) do
    User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
  end

  let(:project) do
    user.projects.create!(:key => "Foo", :name => "Foo")
  end

  let(:issue) do
    Issue.create!(:summary => "Foo", :project_id => project.id, :issue_type_id => 1)
  end

  context :logged_in do
    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :issue_id => issue.id, :comment => { :message => "Foo" }, :format => :pjax
      end

      it "should render the comment view" do
        response.should render_template "comments/_comment"
      end
    end
  end
end
