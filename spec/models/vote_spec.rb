require 'spec_helper'

describe Vote do
  describe :associations do
    it { should belong_to :user }
    it { should belong_to :votable }
  end

  describe :security do
    it { should allow_mass_assignment_of :weight }
  end

  describe :validations do
    it { should validate_presence_of :user }
  end
end
