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

	def gravatar_image_tag(email, options = {})
		gravatar_overrides = options.delete(:gravatar)
		options[:src] = gravatar_image_url(email, gravatar_overrides)
		options[:alt] ||= 'Gravatar'
		if GravatarImageTag.configuration.include_size_attributes
			size = GravatarImageTag::gravatar_options(gravatar_overrides)[:size] || 80
			options[:height] = options[:width] = size.to_s
		end

		# Patch submitted to rails to allow image_tag here
		# https://rails.lighthouseapp.com/projects/8994/tickets/2878
		tag 'img', options, false, false
	end

end
