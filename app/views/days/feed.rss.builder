#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "The Transfiguration"
    xml.author "Umbrella Man"
    xml.description "Day after day"
    xml.link "http://www.kevinvognar.com/days"
    xml.language "en"

    for day in @days
      xml.item do
        xml.title "#{day.title} of the Day ##{day.number}"
        xml.author "Umbrella Man"
        xml.pubDate day.publish_date.to_s(:rfc822)
        xml.link day_url(day)
        xml.guid day.slug

        if day.has_photo?
          image_tag = "<p><img src='#{day.photo.url(:medium)}' title='#{day.mouseover}' /></p>"
        else
          image_tag = ''
        end
        xml.description "<p>#{image_tag} #{markdown(day.body)}</p>".html_safe

      end
    end
  end
end
