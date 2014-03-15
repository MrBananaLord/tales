module NoticesHelper
  def notices
    notices = []
    flash.each do |kind, message|
      notices << render_notice(kind, message) unless message.nil?
    end
    
    content_tag(:ul, notices.join("").html_safe, class: "notices") if notices.any?
  end
  
  private
  
  def render_notice(kind, message)
    render "application/notice", kind: kind, message: message
  end
end
