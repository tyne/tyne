require 'spec_helper'

describe AvatarHelper do
  let(:user) { create(:user) }
  let(:no_gravatar_user) { create(:user, :gravatar_id => nil) }

  describe :avatar do
    it "should return an image tag for the user's gravatar account" do
      avatar = helper.avatar(user)
      avatar.should =~ /img/
      avatar.should =~ /#{user.gravatar_id}/
    end

    it "should return an image tag with a default image if user has no gravatar account" do
      avatar = helper.avatar(no_gravatar_user)
      avatar.should =~ /img/
    end
  end
end
