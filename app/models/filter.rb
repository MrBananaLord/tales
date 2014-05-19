class Filter
  attr_reader :name, :klass
  
  def initialize(klass, name)
    @klass = klass
    @name = name.to_s
  end
  
  def to_s
    I18n.t("#{klass.to_s.underscore}.filters.#{name}")
  end
  
  def value
    name
  end
  
  def resolve
    klass.send(name)
  end
end
