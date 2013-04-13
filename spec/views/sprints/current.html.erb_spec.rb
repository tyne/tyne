require 'spec_helper'

describe "sprints/current.html.erb" do
  let(:sprint) { sprints(:alpha) }

  before :each do
    assign(:sprint, sprint)
  end
  context "when collaborator" do
    before :each do
      view.stub(:is_collaborator?) { true }
    end

    it "renders a finish button" do
      render
      rendered.should have_link("Finish")
    end

    it "renders a link to the burn down chart" do
      render
      rendered.should have_link("View Burn Down")
    end
  end

  context "when not collaborator" do
    before :each do
      view.stub(:is_collaborator?) { false }
    end

    it "does not render a finish button" do
      render
      rendered.should_not have_link("Finish")
    end

    it "does not render a link to the burn down chart" do
      render
      rendered.should_not have_link("View Burn Down")
    end
  end
end
