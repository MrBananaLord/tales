module ApplicationHelper
  def action_link_to(name, url, options = {}, &block)
    condition = options[:if].nil? ? true : options[:if]
    name = capture(&block) if block_given?
    name = I18n.t("actions.#{name}") if name.class == Symbol
    options[:class] ||= "btn-default"
    options[:class] = [options[:class], "btn"]
    link_to name, url, options if condition
  end
end
