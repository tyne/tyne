FactoryGirl.define do
  factory :issue do
    summary "Foo"
    description "Bar"
    issue_type { IssueType.first }
    number 1
    project
    estimate { Issue::VALID_ESTIMATES[rand(0...Issue::VALID_ESTIMATES.count)] }
  end
end
