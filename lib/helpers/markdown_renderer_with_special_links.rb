class MarkdownRendererWithYoutubeLinks < Redcarpet::Render::HTML

  def link(link, title, content)
    if content == '[youtube]'
      youtube_embed(link)
    else
      normal_link(link, title, content)
    end
  end

  def normal_link(link, title, content)
    "<a title=\"#{title}\" href=\"#{link}\" target=\"_blank\">#{content}</a>"
  end

  def youtube_embed(link)
    "<iframe class=\"youtube\" src=\"//www.youtube.com/embed/#{link}?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
  end

end
