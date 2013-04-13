require 'spec_helper'

describe Label do
  it { should belong_to :project }
  it { should have_and_belong_to_many :issues }
end
