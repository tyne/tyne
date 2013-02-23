require 'spec_helper'

describe OrganizationMembership do
  describe :associations do
    it { should belong_to :organization }
    it { should belong_to :user }
  end

  describe :validations do
    it { should validate_uniqueness_of(:user_id).scoped_to(:organization_id) }
  end
end
