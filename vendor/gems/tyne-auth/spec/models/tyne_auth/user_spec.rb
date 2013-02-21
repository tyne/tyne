require 'spec_helper'

describe TyneAuth::User do
  describe :associations do
    it { should have_many :organization_memberships }
    it { should have_many :organizations }
  end

  describe :validations do
    it { should validate_presence_of :name }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :token }
  end

  describe :security do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :username }
    it { should allow_mass_assignment_of :uid }
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :token }
  end

  describe :find_or_create do
    context "when user exists" do
      before :each do
        TyneAuth::User.stub(:find_by_uid).and_return(:foo)
      end

      it "should return the existing user" do
        TyneAuth::User.find_or_create({}).should == :foo
      end
    end

    context "when user does not exist" do
      let(:auth_details) do
        HashWithIndifferentAccess.new(:uid => "1", :info => { :name => "Foo", :nickname => "Bar", :email => "foo@bar.com" }, :credentials => { :token => "123456" }, :extra => { :raw_info => { :gravatar_id => "1" } })
      end

      it "should create a new user" do
        expect do
          TyneAuth::User.find_or_create(auth_details)
        end.to change {TyneAuth::User.count}.by(1)
      end

      it "should set the provided auth details to the user" do
        new_user = TyneAuth::User.find_or_create(auth_details)
        new_user.uid = "1"
        new_user.name = "Foo"
        new_user.username = "Bar"
        new_user.email = "foo@bar.com"
        new_user.token = "123456"
      end

      it "should default the name to the nickname if not given in the auth details" do
        auth_details[:info].delete(:name)
        new_user = TyneAuth::User.find_or_create(auth_details)
        new_user.name = "Foo"
        new_user.username = "Foo"
      end
    end
  end

  describe :github_client do
    it "should return a new instance of the github client" do
      user = TyneAuth::User.new(:username => "Foo", :token => "Bar")
      user.github_client.should be_an_instance_of Octokit::Client
    end
  end
end
