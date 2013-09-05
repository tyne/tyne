require 'spec_helper'

describe SessionsController do
  before :each do
    subject.stub(:current_user).and_return(User.new)
  end

  describe :destroy do
    it "should clear the session" do
      subject.session[:user_id] = :bar

      delete :destroy

      subject.session[:user_id].should be_nil
    end

    it "should redirect to login" do
      delete :destroy

      subject.response.should redirect_to(login_path)
    end
  end

  describe :failure do
    it "should set an information in the flash" do
      subject.should_receive(:flash).and_return({})

      get :failure
    end

    it "should redirect to login path" do
      get :failure

      subject.response.should redirect_to(login_path)
    end
  end

  describe :create do
    before :each do
      @omniauth = {:foo => "bar", "provider" => "provider"}
      subject.request.env["omniauth.auth"] = @omniauth
    end

    context "user is logged in" do
      before :each do
        processor = double
        AuthProcessor.stub(:new).with(@omniauth) { processor }
        mock_user = stub_model(User, :id => 1)
        subject.session[:user_id] = :bar
        processor.should_receive(:find_or_create_user).and_return(mock_user)
      end

      it "should redirect to root" do
        post :create, :provider => "test"

        subject.response.should redirect_to(root_path)
      end
    end

    context "user is logged out" do
      before :each do
        mock_user = stub_model(User, :id => 1)
        processor = double
        subject.stub(:session).and_return({})
        AuthProcessor.stub(:new).with(@omniauth) { processor }
        processor.should_receive(:find_or_create_user).and_return(mock_user)
      end

      it "should redirect to root" do
        post :create, :provider => "test"

        response.should redirect_to(root_path)
      end
    end
  end
end
