module Reports
  class BurnDown
    def initialize(project)
      @project = project

      @options = { :width => "100%", :height => 500, :title => 'Burn Down', :is3D => false, :pointSize => 5}
    end

    def to_chart
      sprint = @project.sprints.find_by_active(true)
      max = sprint.activities.find_by_type("start").sum(:scope_change)
      days = (sprint.end_date - sprint.start_date).to_i

      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('date', "Date")
      data_table.new_column('number', "Story Points")
      data_table.new_column('number', "Estimated")
      data_table.add_rows(days)

      (0...days).each do |day|
        data_table.set_cell(day, 0, sprint.start_date + day.days)
        data_table.set_cell(day, 1, 5)
        data_table.set_cell(day, 2, (max/days) * (days-day))
      end


      # sample = [
      #   [7.days.ago.to_date, 35, 35],
      #   [6.days.ago.to_date, 28, (35/7.0) * 6],
      #   [5.days.ago.to_date, 23, (35/7.0) * 5],
      #   [4.days.ago.to_date, 15, (35/7.0) * 4],
      #   [3.days.ago.to_date, 8, (35/7.0) * 3],
      #   [2.day.ago.to_date, nil, (35/7.0) * 2],
      #   [1.day.ago.to_date, nil, (35/7.0) * 1],
      #   [Date.today, nil, 0],
      # ]


      GoogleVisualr::Interactive::LineChart.new(data_table, @options)
    end
  end
end
