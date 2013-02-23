require 'spec_helper'

describe ReportsController do
  let(:user) do
    User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
  end

  let(:project) do
    user.projects.create!(:key => "Foo", :name => "Foo")
  end

  context :logged_in do
    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :index, :user => user.username, :key => project.key
      end

      it "render the correct template" do
        response.should render_template 'reports/index'
      end
    end

    describe :index do
      before :each do
        get :issue_type_ratio, :user => user.username, :key => project.key
      end

      it "render the correct template" do
        response.should render_template 'reports/issue_type_ratio'
      end

      it "should assign a pie chart" do
        assigns(:chart).should be_a GoogleVisualr::Interactive::PieChart
      end
    end
  end
end
