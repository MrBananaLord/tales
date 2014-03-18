# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_tag = :div
  config.error_notification_class = 'alert alert-error'
  config.label_class = "control-label col-sm-2"
  config.input_class = "form-control"
  config.button_class = "btn btn-default"
  config.browser_validations = false
  
  config.wrappers :bootstrap, :tag => 'div', :class => 'form-group', :error_class => 'error' do |b|
    b.use :html5
    b.use :label
    b.use :placeholder
    b.use :input
    b.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
    b.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
  end

  config.wrappers :prepend, :tag => 'div', :class => "form-group", :error_class => 'error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper :tag => 'div', :class => 'col-sm-8' do |input|
      input.wrapper :tag => 'div', :class => 'input-prepend' do |prepend|
        prepend.use :input
      end
      input.use :hint,  :wrap_with => { :tag => 'span', :class => 'help-block' }
      input.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
    end
  end

  config.wrappers :append, :tag => 'div', :class => "form-group", :error_class => 'error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper :tag => 'div', :class => 'col-sm-6' do |input|
      input.wrapper :tag => 'div', :class => 'input-append' do |append|
        append.use :input
      end
      input.use :hint,  :wrap_with => { :tag => 'span', :class => 'help-block' }
      input.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
    end
  end
  
  config.wrappers :inline_checkbox, :tag => 'div', :class => 'control-group', :error_class => 'error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper :tag => 'div', :class => 'controls' do |ba|
      ba.wrapper :tag => 'label', :class => 'checkbox' do |bb|
        bb.use :input
        bb.use :label_text
      end
      ba.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end
  
  config.default_wrapper = :bootstrap
end
