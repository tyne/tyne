# View helper to build filter panel for the backlog
module FilterHelper
  # Creates a filter option to exclude the filter
  def filter_option_all(form_builder, field)
    options = {}
    options[:label] = "All"
    options[:required] = false
    options[:input_html] = { :id => "filter_#{field}_all", :type => :checkbox, :value => ''}
    options[:label_html] = { :for => "filter_#{field}_all" }
    options[:label_html][:class] = "selected" unless contains_filter_option(field)
    options[:wrapper_html] = { :class => "filter-controls-hidden" }

    klass = ["filter-options"]
    klass << "selected" unless contains_filter_option(field)

    content_tag :li, form_builder.input(field, options), :class => klass.join(' ')
  end

  # Creates a particular filter option
  def filter_option(form_builder, field, option)
    selected = matches_filter_option(field, option[1])
    options = {}
    options[:label] = option[0]
    options[:required] = false
    options[:input_html] = { :id => "filter_#{field}_#{option[1]}", :type => :checkbox, :value => option[1], :multiple => true }
    options[:input_html][:checked] = selected
    options[:label_html] = { :for => "filter_#{field}_#{option[1]}" }
    options[:wrapper_html] = { :class => "filter-controls-hidden" }

    klass = ["filter-options"]
    klass << "selected" if selected

    add_filter_klass = ["filter-add"]
    if selected
      add_filter_klass << "icon-remove"
    else
      add_filter_klass << "icon-plus"
    end

    content = link_to("", "#", :class => add_filter_klass.join(' '))
    content << form_builder.input(field, options)

    content_tag :li, content, :class => klass.join(' ')
  end

  private
  def contains_filter_option(option)
    return false unless params[:filter]
    return params[:filter][option.to_s].present?
  end

  def matches_filter_option(field, option)
    return false unless contains_filter_option(field)

    return params[:filter][field].include?(option.to_s)
  end
end
