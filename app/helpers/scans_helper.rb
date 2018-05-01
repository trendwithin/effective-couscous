module ScansHelper
  def render_unless_empty obj
    unless obj.empty?
      render partial: 'scans/scan_items', locals: { obj: obj }
    else
      "<h4>No Result</h4>".html_safe
    end
  end
end
