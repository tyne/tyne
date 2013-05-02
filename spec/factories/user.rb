FactoryGirl.define do
  factory :user do
    name "Test"
    username "test"
    email "foo@bar.com"
    gravatar_id "foo"
    password "foofoofoo"
  end

  factory :bob, :class => "User" do
    name "Bob"
    username "bob"
    email "bar@baz.com"
    gravatar_id "bob"
    password "foofoofoo"
  end
end
