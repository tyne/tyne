require 'spec_helper'

describe AuthProcessor do
  let(:auth_details) do
    {
      'uid' => "1",
      'info' => {
        'name' => "Foo",
        'nickname' => "Bar",
        'email' => "foo@bar.com"
      },
      'credentials' => {
          'token' => "123456"
      },
      'extra' => {
          'raw_info' => {
            'gravatar_id' => "1"
          }
      }
    }
  end

  subject { described_class.new(auth_details) }

  describe :find_or_create_user do
    context "when user exists" do
      before :each do
        User.stub(:find_by_uid).and_return(:foo)
      end

      it "should return the existing user" do
        subject.find_or_create_user.should == :foo
      end
    end

    context "when user does not exist" do
      before :each do
        User.stub(:find_by_uid).and_return(nil)
        User.stub(:create!) do |&block|
          OpenStruct.new.tap {|u| block.call(u) }
        end
      end

      it "should create a new user" do
        User.should_receive(:create!)
        subject.find_or_create_user
      end

      it "should set the provided auth details to the user" do
        new_user = subject.find_or_create_user
        new_user.uid.should == "1"
        new_user.name.should  == "Foo"
        new_user.username.should  == "Bar"
        new_user.email.should == "foo@bar.com"
        new_user.token.should == "123456"
      end

      it "should default the name to the nickname if not given in the auth details" do
        auth_details['info'].delete('name')
        new_user = subject.find_or_create_user
        new_user.name.should == "Bar"
      end

      it "does fallback the name to the nickname if empty" do
        auth_details['info']['name'] = ""
        new_user = subject.find_or_create_user
        new_user.name.should == "Bar"
      end
    end
  end
end
