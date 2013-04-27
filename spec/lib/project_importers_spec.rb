require 'spec_helper'

class TestImporter
  def initialize(user); end
end

describe ProjectImporters do
  let(:user) { users(:tobscher) }

  before :each do
    if ProjectImporters.registered_importers.include?(:foo)
      ProjectImporters.registered_importers.delete(:foo)
    end
  end

  describe :register do
    it "registers an importer with the given name" do
      expect do
        ProjectImporters.register(:foo, TestImporter)
      end.to change(ProjectImporters.registered_importers, :length).by(1)
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
