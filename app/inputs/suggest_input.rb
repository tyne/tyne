# Creates an input that allows the user to select arbritary data.
# The data gets suggested via a controller action.
class SuggestInput < SimpleForm::Inputs::Base
  # Renders the markup for the suggest widget
  def input
    input_html_options.merge!(:data => { :url => options[:url] })

    @builder.text_field(attribute_name, input_html_options) + \
      @builder.hidden_field(attribute_name)
  end
end
