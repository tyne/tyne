FactoryGirl.define do
  factory :user do
    name "Test"
    username "test"
    uid 123456
    token "foo"
    gravatar_id "foo"
  end

  factory :bob, :class => "User" do
    name "Bob"
    username "bob"
    uid 1337
    token "bob"
    gravatar_id "bob"
  end
end
