require './lib/helpers/markdown_renderer_with_special_links'
module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(MarkdownRendererWithYoutubeLinks,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       autolink: true,
                                       disable_indented_code_blocks: true,
    )
    return markdown.render(text).html_safe
  end
end
