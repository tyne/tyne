require 'spec_helper'

describe :burn_down_chart do
  include_context 'authenticated'

  it "should display a burn down report for the current sprint", :js => true do
    login

    create_project("Foo")
    create_issue("Foo")
    create_issue("Bar")
    create_issue("Baz")

    create_sprint
    start_sprint

    logout
  end
end
