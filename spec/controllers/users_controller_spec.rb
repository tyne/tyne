require 'spec_helper'

describe UsersController do
  let(:user) { users(:tobscher) }

  before :each do
    controller.stub(:current_user).and_return(user)
  end

  describe :edit do
    before :each do
      get :edit, :user => user.username
    end

    it "should assign the current_user" do
      assigns(:user).should == user
      response.should render_template "users/edit"
    end
  end

  describe :update do
    before :each do
      put :update, :user => user.username, :account => { :notification_email => "foo@bar.com" }
    end

    it "should update the current user" do
      assigns(:user).notification_email.should == "foo@bar.com"
      response.should redirect_to(edit_account_settings_path(:user => user.username))
    end
  end
end
