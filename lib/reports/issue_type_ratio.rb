module Reports
  # Contains logic to create a issue type ratio report
  class IssueTypeRatio

    def initialize(project)
      @project = project

      @options = { :width => 800, :height => 600, :title => 'Issue Type Ratio', :is3D => false }
    end

    # Returns the chart data in a google chart tools compliant format.
    # The report is rendered as a pie chart
    def to_chart
      issue_types = IssueType.all
      issues = @project.backlog_items

      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Issue Type')
      data_table.new_column('number', 'Numbers')
      data_table.add_rows(issue_types.count)

      issue_types.each_with_index do |issue_type, index|
        value = issues.select {|x| x.issue_type == issue_type}.count
        label = issue_type.name
        data_table.set_cell(index, 0, label)
        data_table.set_cell(index, 1, value)
      end

      GoogleVisualr::Interactive::PieChart.new(data_table, @options)
    end
  end
end
