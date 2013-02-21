FactoryGirl.define do
  factory :user, :class => "TyneAuth::User" do
    name "Test"
    username "test"
    uid 123456
    token "foo"
    gravatar_id "foo"
  end

  factory :bob, :class => "TyneAuth::User" do
    name "Bob"
    username "bob"
    uid 1337
    token "bob"
    gravatar_id "bob"
  end
end
