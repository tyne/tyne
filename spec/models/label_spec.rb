require 'spec_helper'

describe Label do
  it { should belong_to :project }
  it { should have_many :issues }
end
