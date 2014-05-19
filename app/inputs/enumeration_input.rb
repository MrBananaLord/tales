class EnumerationInput < SimpleForm::Inputs::CollectionSelectInput
  def collection
    @collection ||= enumeration.select_options
  end
  
  private
  
  def input_options
    super[:selected] = enumeration.value unless super.has_key?(:selected)
    super[:include_blank] = enumeration.allow_blank unless super.has_key?(:include_blank)
    super
  end
  
  def enumeration
    @enumeration ||= @builder.object.send(attribute_name)
  end
end
