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
end
