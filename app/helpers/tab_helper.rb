module TabHelper
  def tab_for(name, tab, link)
    if tab.to_s == @current_tab.to_s
        css = 'selected'
    else
        css = 'normal'
    end
      content_tag(:li, link_to(name,link, :class => css))
   end
end