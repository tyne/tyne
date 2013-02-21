require 'spec_helper'

describe TyneCore::Team do
  it { should belong_to :project }
  it { should have_many :members }
end
