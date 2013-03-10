require 'spec_helper'

describe :projects do
  include_context 'authenticated'

  it "should create a new project" do
    login

    create_project('Foo')
    create_issue('Bar')

    page.should have_content 'Bar'

    logout
  end

  describe :private do
    before do
      login
      create_project('Foo', :private => :true)
    end

    after do
      logout
    end

    it "should create a private project" do
      create_issue('Bar')

      page.should have_content 'Bar'
    end
  end
end
