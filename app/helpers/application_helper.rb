module ApplicationHelper
  def action_link_to(action, resource, options = {}, &block)
    name = capture(&block) if block_given?
    
    name ||= options.delete(:name) || t("actions.#{action.to_s}")
    url = options[:url] || set_url(action, resource)
    options[:class] ||= "btn-default"
    options[:class] = [options[:class], "btn"]
    if can?(action, resource)
      link_to name, url, options
    end
  end
  
  private
  
  def set_url(action, resource)
    if resource.class == Class
      [action, resource.to_s.downcase.to_sym]
    else
      [action, resource]
    end
  end
end
