module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:hard_wrap => true)
    options = {hard_wrap: true, no_intra_emphasis: true}
    md = Redcarpet::Markdown.new(renderer, options)
    md.render(text).html_safe
  end
end
