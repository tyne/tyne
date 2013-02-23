shared_context 'authenticated' do
  before :each do
    @nickname = 'test'

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          :provider => 'github',
          :uid => '123545',
          :info => { 'name' => 'test', :email => 'me@example.com', :nickname => @nickname },
          :credentials => { 'token' => '123456' },
          :extra => { 'raw_info' => { 'gravatar_id' => '123456' } }
    })
  end

  def login
    visit root_path
    click_link 'Sign in with Github'
  end

  def logout
    click_link "user_dropdown"
    click_link "Logout"
  end

  def create_project(name)
    @project_key = 'FOO'

    first(:link, "New Project").click

    within("#new_project") do
      fill_in 'Key', :with => @project_key
      fill_in 'Name', :with => name
      fill_in 'Description', :with => name
    end

    click_button 'Create Project'
  end

  def create_issue(summary)
    click_link "Create"

    within("#new_issue") do
      fill_in 'Summary', :with => summary
    end

    click_button "Create Issue"
  end
end
