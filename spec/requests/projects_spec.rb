require 'spec_helper'

describe :projects do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          :provider => 'github',
          :uid => '123545',
          :info => { 'name' => 'test', :email => 'me@example.com', :nickname => 'test' },
          :credentials => { 'token' => '123456' },
          :extra => { 'raw_info' => { 'gravatar_id' => '123456' } }
    })
  end

  it "should create a new project" do
    visit root_path
    click_link 'Sign in with Github'

    click_link "New Project"

    within("#new_project") do
      fill_in 'Key', :with => "FOO"
      fill_in 'Name', :with => "Foo"
      fill_in 'Description', :with => "Foo"
    end

    click_button 'Create Project'
    page.should have_content 'Foo'
  end
end
