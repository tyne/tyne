require 'spec_helper'

describe :datepicker do
  before :each do
    concat input_for(:foo, :start_date, :as => :datepicker)
  end

  it "should render an input" do
    assert_select 'input[type="text"]'
  end

  it "should render an input" do
    assert_select 'input[type="hidden"]'
  end
end
