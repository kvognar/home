require './lib/helpers/markdown_renderer_with_special_links'
module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(MarkdownRendererWithSpecialLinks,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       autolink: true,
                                       disable_indented_code_blocks: true,
                                       escape_html: true
    )
    markdown.render(text).html_safe
  end

  #def svg(name)
  #  file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
  #  return File.read(file_path).html_safe if File.exists?(file_path)
  #  '(not found)'
  #end

  def svg(name, title: nil)
    file = File.read(Rails.root.join('app', 'assets', 'images', "#{name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    "<span title='#{title}'>#{svg.to_html}</span>".html_safe
  end
end
