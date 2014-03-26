module ApplicationHelper
  def action_link_to(action, resource, url = nil, options = {}, &block)
    name = capture(&block) if block_given?
    name ||= options.delete(:name) || t("actions.#{action}")
    url ||= [action, resource]
    options[:class] ||= "btn-default"
    options[:class] = [options[:class], "btn"]
    if can?(action, resource)
      link_to name, url, options
    end
  end
end
