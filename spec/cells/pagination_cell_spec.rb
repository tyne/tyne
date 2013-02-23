require 'spec_helper'

describe PaginationCell do
  subject { cell(:pagination) }

  describe :show do
    it "should render the view" do
      subject.should_receive(:render)
      subject.show
    end
  end
end
