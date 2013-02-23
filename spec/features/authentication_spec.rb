require 'spec_helper'

describe :authentication do
  before :each do
    OmniAuth.config.test_mode = false

    Capybara.run_server = true
    Capybara.app_host = "http://localhost:3000"
    Capybara.server_port = 3000
  end

  describe :github do
    it "authenticates via github", :js => true, :slow => true do
      visit root_path
      click_link 'Sign in with Github'

      within("#login") do
        fill_in 'login_field', :with => ENV["CAPYBARA_USER"]
        fill_in 'password', :with => ENV["CAPYBARA_PASSWORD"]
      end

      click_button "Sign in"

      click_link "user_dropdown"
      click_link "Logout"
    end
  end
end
