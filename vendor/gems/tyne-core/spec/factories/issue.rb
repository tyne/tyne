FactoryGirl.define do
  factory :issue, :class => "TyneCore::Issue" do
    summary "Foo"
    description "Bar"
    issue_type_id 1
    number 1
    project
  end
end
