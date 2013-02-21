require 'spec_helper'

# Test controller to test integration
class TestController < ActionController::Base
  before_filter :require_login, :only => [:new]

  def index
    render :text => "Foo"
  end

  def new
    render :text => "Bar"
  end
end

describe TyneAuth::Extensions::ActionController, :type => :controller do
  before :all do
    Rails.application.routes.draw do
      controller :test do
        get 'test/index' => :index
        get 'test/new' => :new
      end
    end

    @controller = TestController.new
  end

  context :logged_in do
    before :each do
      subject.stub(:current_user).and_return(:foo)
    end

    it "should not deny access" do
      get :index
      response.should be_success
    end
  end

  context :login_required do
    it "should deny access" do
      get :new
      response.should redirect_to login_path
    end
  end

  after :all do
    Rails.application.reload_routes!
  end
end
