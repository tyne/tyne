require 'spec_helper'

class TestImporter
  def initialize(user); end
end

describe ProjectImporters do
  let(:user) { users(:tobscher) }

  before :each do
    ProjectImporters.registered_importers.clear
  end

  describe :register do
    it "registers an importer with the given name" do
      ProjectImporters.register(:foo, TestImporter)
      ProjectImporters.registered_importers.should have(1).item
    end
  end

  describe :obtain do
    it "returns an instance of the registered importer" do
      expected = TestImporter
      ProjectImporters.register(:foo, expected)
      ProjectImporters.obtain(:foo, user).should be_instance_of(expected)
    end

    it "raises an error if the importer is not registered" do
      expect do
        ProjectImporters.obtain(:bar, user)
      end.to raise_error(ProjectImporters::NoImporterError)
    end
  end
end
