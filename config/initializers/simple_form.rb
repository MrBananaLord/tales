inputs = %w[
  FileInput
]
#  CollectionSelectInput
#  DateTimeInput
#  GroupedCollectionSelectInput
#  NumericInput
#  PasswordInput
#  RangeInput
#  StringInput
#  TextInput
#]
 
inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize
 
  new_class = Class.new(superclass) do
    def input_html_classes
      super.reject{ |klass| klass == "form-control" }
    end
  end
 
  Object.const_set(input_type, new_class)
end

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_tag = :div
  config.error_notification_class = 'alert alert-error'
  config.label_class = "control-label"
  config.input_class = "form-control"
  config.button_class = "btn btn-default"
  config.browser_validations = false
  
  config.wrappers :bootstrap, tag: 'div', class: 'form-group',
                  error_class: 'has-error' do |b|
    b.use :html5
    b.use :label
    b.use :placeholder
    b.use :input
    b.use :error, wrap_with: { tag: 'div', class: 'help-block has-error' }
    b.use :hint, wrap_with: { tag: 'div', class: 'help-block' }
  end
  
  config.wrappers :inline_checkbox, tag: 'div', class: 'control-group',
                  error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'div', class: 'controls' do |ba|
      ba.wrapper tag: 'label', class: 'checkbox' do |bb|
        bb.use :input
        bb.use :label_text
      end
      ba.use :error, wrap_with: { tag: 'div', class: 'help-block' }
      ba.use :hint, wrap_with: { tag: 'div', class: 'help-block' }
    end
  end
  
  config.default_wrapper = :bootstrap
end
