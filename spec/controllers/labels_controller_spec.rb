require 'spec_helper'

describe LabelsController do
  context :private_project do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:bluffr) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :privacy do
      it "responds with 404 if user has no access to a private project" do
        post :create, :project_id => project.id, :label => { :name => "Foo" }
        response.status.should == 404

        delete :destroy, :project_id => project.id, :id => 15
        response.status.should == 404
      end
    end
  end

  context :logged_in do
    let(:user) { users(:tobscher) }
    let(:project) { projects(:tyne) }

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :create do
      it "creates a new label" do
        expect do
          post :create, :project_id => project.id, :label => { :name => "Foo", :colour => "#ff0000"}, :format => :pjax
        end.to change(Label, :count).by(1)

        Label.last.project.should == project
        Label.last.name.should == "Foo"
        Label.last.colour.should == "#ff0000"
      end

      it "renders the label template" do
        post :create, :project_id => project.id, :label => { :name => "Foo", :colour => "#ff0000"}, :format => :pjax
        response.should render_template "labels/_label"
      end
    end

    describe :destroy do
      let!(:label) do
        project.labels.create!(:name => "Foo", :colour => "#ff0000")
      end

      it "removes the label from the database" do
        expect do
          delete :destroy, :project_id => project.id, :id => label.id, :format => :js
        end.to change(Label, :count).by(-1)
      end

      it "renders the correct template" do
        delete :destroy, :project_id => project.id, :id => label.id, :format => :js
        response.should render_template "labels/destroy"
      end
    end
  end
end
