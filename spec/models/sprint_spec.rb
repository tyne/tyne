require 'spec_helper'

describe Sprint do
  let(:user) { create(:user) }
  let(:project) { create(:project, :user => user) }

  describe :start do
    it "should create an positive activity entry for each sprint" do
      issues = create_list(:issue, 5, :project => project)

      sprint = project.sprints.build(:name => "Foo")
      sprint.issues << issues.map{|x| x.becomes(SprintItem)}

      sprint.save!

      sprint.start(Date.today, Date.today + 7.days)

      sprint.activities.where(:type_of_change => "start").scope_change.should == issues.sum { |x| x.estimate }
    end
  end
end
