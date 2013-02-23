require 'spec_helper'

describe User do
  describe :initialisation do
    it "should build a new dashboard for every new user" do
      described_class.new.dashboards.length.should == 1
    end
  end

  describe :default_dashboard do
    it "should default to the first dashboard" do
      user = described_class.new
      user.default_dashboard.should == user.dashboards.first
    end
  end
end
