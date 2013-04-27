require 'spec_helper'

describe ProjectImporters::JSON do
  let(:user) { users(:tobscher) }

  subject do
    described_class.new(user)
  end

  it "is registered as :json" do
    ProjectImporters.registered_importers[:json].should == described_class
  end

  describe :import do
    let(:data) {
        { :project => {
          :key => "IMP",
          :name => "Import",
          :issues => [{
            :summary => "Imp1",
            :description => "Imported 1"
          }, {
            :summary => "Imp2",
            :description => "Imported 2"
          }, {
            :summary => "Imp3",
            :description => "Imported 3"
          }]
        }
      }
    }

    it "creates a new project" do
      expect do
        subject.import(:data => { :json => data.to_json })
      end.to change(Project, :count).by(1)

      p = Project.last
      p.key.should == "IMP"
      p.name.should == "Import"
    end

    it "creates an issue for each entry in the list" do
      expect do
        subject.import(:data => { :json => data.to_json })
      end.to change(Issue, :count).by(3)

      Issue.last.summary.should == "Imp3"
      Issue.last.description.should == "Imported 3"
      Issue.last.reported_by.should == user
    end
  end
end
