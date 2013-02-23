module FormBuilder
  # Specialised form builder in order to display a disabled form
  class DisabledFormBuilder < SimpleForm::FormBuilder
    # Appends a disabled attribute to the input
    def input(attribute_name, options = {}, &block)
      options[:input_html] ||= {}
      options[:input_html].merge! :disabled => 'disabled'
      super
    end

    # Appends a disabled attribute to the button
    def button(type, *args, &block)
      options = args.extract_options!
      options.merge! :disabled => 'disabled'
      super(type, options, &block)
    end
  end
end
