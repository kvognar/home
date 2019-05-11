class MarkdownRendererWithSpecialLinks < Redcarpet::Render::HTML

  def link(link, title, content)
    if content == '[youtube]'
      youtube_embed(link)
    elsif ['.jpg', '.png', '.gif'].any? { |extension| link.include?(extension) }
      "<a href='#' data-featherlight=#{link} title=#{title}>#{content}</a>"
    elsif day_match = link.match(/^day:(\d)$/)
      number = day_match.captures.first.to_i
      path = Rails.application.routes.url_helpers.day_path(Day.find_by(number: number))
      "<a href=#{path} title=#{title}>#{content}</a>"
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
