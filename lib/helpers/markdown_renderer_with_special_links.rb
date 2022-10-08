class MarkdownRendererWithSpecialLinks < Redcarpet::Render::HTML

  def link(link, title='', content)
    if content == '[youtube]'
      youtube_embed(link)
    elsif %w[.jpg .jpeg .png .gif].any? { |extension| link.downcase.include?(extension) }
      "<a href='#' data-featherlight=#{link} title='#{escape(title)}'>#{escape(content)}</a>"
    elsif day_match = link.match(/^day:(\d+)$/)
      number = day_match.captures.first.to_i
      day = Day.find_by(number: number)
      if day.present?
        path = Rails.application.routes.url_helpers.day_path(Day.find_by(number: number))
      else
        path = '#'
        puts 'no such day'
      end
      "<a href=#{path} title='#{escape(title)}'>#{escape(content)}</a>"
    else
      normal_link(link, title, content)
    end
  end

  def image(link, title='', alt_text='')
    <<~HTML
    <a href='#' data-featherlight='#{link}' title='#{escape(title)}'>
    <img src='#{link}' title='#{escape(title)}' alt='#{escape(alt_text)}' />
    </a>
    HTML
  end

  def escape(string=nil)
    CGI::escapeHTML(string || '')
  end

  def normal_link(link, title, content)
    "<a title=\"#{title}\" href=\"#{link}\" target=\"_blank\">#{content}</a>"
  end

  def youtube_embed(link)
    "<iframe class=\"youtube\" src=\"//www.youtube.com/embed/#{link}?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
  end

end
