module MetaTagsHelper
  def title(string)
    titles << string unless string.blank?
    string
  end

  def page_title(base = nil)
    [*titles, base].compact.join(" - ").html_safe
  end

  def current_title
    titles.last
  end
  
  private

  def titles
    @titles ||= []
  end
end
