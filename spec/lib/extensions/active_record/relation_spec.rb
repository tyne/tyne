require 'spec_helper'

describe ActiveRecord::Relation do
  subject do
    Project.scoped
  end

  describe :cache_key do
    context :empty do
      before :each do
        subject.stub(:empty?).and_return(true)
      end

      it "should include empty in the cache key" do
        subject.cache_key.should =~ /empty/
      end
    end

    context :not_empty do
      let(:user) { User.create!(:name => "Foo", :uid => 1337, :token => "Secure") }

      before :each do
        user.projects.create!(:key => "FOO", :name => "Foo")
        user.projects.create!(:key => "BAR", :name => "Bar")
      end

      it "should create different cache keys for different scopes" do
        subject.cache_key.should_not == subject.where(:key => "Bar").cache_key
      end
    end
  end
end
