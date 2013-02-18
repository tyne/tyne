require 'spec_helper'

describe :projects do
  include_context 'authenticated'

  it "should create a new issue" do
    login

    create_project('Foo')
    create_issue('Bar')

    page.should have_content 'Bar'

    logout
  end

  it "should update an issue" do
    expected = "Lorem ipsum dolor sit"

    login

    create_project 'Foo'
    create_issue 'Bar'

    click_link "Edit"

    within ".edit_issue" do
      fill_in 'Description', :with => expected
    end

    click_button "Update Issue"

    page.should have_content(expected)

    logout
  end
end
