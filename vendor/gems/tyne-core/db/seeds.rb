TyneCore::IssueType.delete_all
%w(Bug Enhancement Story Feature Task).each do |issue_type|
  TyneCore::IssueType.create!(:name => issue_type)
end

TyneCore::IssuePriority.delete_all
%w(Low Medium High).each_with_index do |issue_priority, index|
  TyneCore::IssuePriority.create!(:name => issue_priority, :number => index)
end
