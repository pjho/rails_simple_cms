module ApplicationHelper
  
  ##
  # Renders MarkDown as HTML
  def markdown(text)
    options = {
      filter_html:     false,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? content_for(:title) + ' | ' + Settings['site.default_page_title'] :  Settings['site.default_page_title']
    end
  end





  # Helper method to make setting names readable
  def setting_name(name)
    name.split('.')[1].gsub('_', ' ').titlecase rescue name
  end
  
  def setting_class(name)
    name.split('.')[1].downcase rescue name
  end



end

