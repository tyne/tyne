IssueType.delete_all
%w(Bug Enhancement Story Feature Task).each do |issue_type|
  IssueType.create!(:name => issue_type)
end

IssuePriority.delete_all
%w(Low Medium High).each_with_index do |issue_priority, index|
  IssuePriority.create!(:name => issue_priority, :number => index)
end
