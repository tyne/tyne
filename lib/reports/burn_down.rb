module Reports
  # Burn Down Chart Report
  class BurnDown
    def initialize(sprint)
      @sprint = sprint

      @options = { :width => "100%", :height => 500, :title => 'Burn Down', :is3D => false, :pointSize => 5}
    end

    # Translates sprint activity into google chart data.
    #
    # @return [GoogleVisualr::Interactive::LineChart] line chart
    def to_chart
      return unless @sprint

      days = (@sprint.end_date - @sprint.start_date).to_i + 1

      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', "Date")
      data_table.new_column('number', "Remaining")
      data_table.new_column('number', "Ideal")
      data_table.add_rows(days + 1)

      data_table.set_cell(0, 0, "Start")
      data_table.set_cell(0, 1, max_value)
      data_table.set_cell(0, 2, max_value)

      days.times.each do |index|
        predicted = (max_value/days) * (days - index - 1)
        to_date = @sprint.start_date + index.days
        data_table.set_cell(index + 1, 0, to_date.to_formatted_s(:short))
        data_table.set_cell(index + 1, 1, get_estimate_to_date(to_date))
        data_table.set_cell(index + 1, 2, round_to_nearest(predicted))
      end
      GoogleVisualr::Interactive::LineChart.new(data_table, @options)
    end

    private
    def get_estimate_to_date(to_date)
      activities = @sprint.activities.where("created_at <= ?", to_date + 1.day)

      return activities.scope_change if to_date <= Date.today
    end

    def max_value
      @max_value ||= @sprint.activities.where(:type_of_change => "start").scope_change
    end

    def round_to_nearest(x)
      x.round(1)
    end
  end
end
