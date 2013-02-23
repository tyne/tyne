FactoryGirl.define do
  factory :issue do
    summary "Foo"
    description "Bar"
    issue_type { IssueType.first }
    number 1
    project
  end
end
