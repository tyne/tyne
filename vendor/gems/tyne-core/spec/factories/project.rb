FactoryGirl.define do
  factory :project, :class => "TyneCore::Project" do
    name "Foo"
    key "Foo"
    user
  end
end
