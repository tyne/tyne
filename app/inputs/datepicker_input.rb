# Creates an input that allows the user to pick a
# date from a calendar.
class DatepickerInput < SimpleForm::Inputs::Base
  # Renders the markup for the datepicker widget
  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    value = value.to_date unless value.nil?

    input_html_options.merge!(:value => value)

    @builder.text_field(attribute_name, input_html_options) + \
      @builder.hidden_field(attribute_name, :class => attribute_name.to_s + "-alt", :value => value)
  end
end
