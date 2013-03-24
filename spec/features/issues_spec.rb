require 'spec_helper'

describe :issues do
  include_context 'authenticated'

  before:each do
    login

    create_project('Foo')
    create_issue('Bar')
  end

  after :each do
    logout
  end

  subject { page }

  it { should have_content 'Bar' }

  context 'when updating an issue' do
    let(:new_description) { 'Lorem ipsum dolor sit' }

    before :each do
      click_link "Edit"

      within ".edit_issue" do
        fill_in 'Description', :with => new_description
      end

      click_button "Update Issue"
    end

    it { should have_content(new_description) }
  end
end
