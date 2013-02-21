require 'spec_helper'

describe TyneCore::PaginationCell do
  subject { cell(:"tyne_core/pagination") }

  describe :show do
    it "should render the view" do
      subject.should_receive(:render)
      subject.show
    end
  end
end
