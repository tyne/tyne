require 'spec_helper'

describe "issues/show.html.erb" do
  let(:user) { create(:user, :username => "Foo") }
  let(:project) { create(:project, :user => user, :key => "Foo") }
  let(:issue) { create(:issue, :project => project, :reported_by => user, :number => 1) }

  before :each do
    assign(:issue, issue)
    view.stub(:current_user).and_return(User.new)
    view.stub(:path_to_issue).and_return('Foo')
  end

  context :can_edit? do
    before :each do
      view.stub(:can_edit?).and_return(true)
    end

    it "should render a form to inline edit summary and description" do
      render
      rendered.should have_selector(".best_in_place", :count => 2)
    end
  end

  context :cannot_edit do
    before :each do
      view.stub(:can_edit?).and_return(false)
    end

    it "should not render the inline edit form" do
      render
      rendered.should_not have_selector(".best_in_place")
    end
  end
end
