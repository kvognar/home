class StaticPagesController < ApplicationController
  def home
    @day = Day.joins(:photo_of_the_day).includes(:photo_of_the_day).last
  end

  def contact
  end
  
  def resume
    send_file(
    "#{Rails.root}/public/resume.pdf",
    filename: "resume.pdf",
    type: "application/pdf"
    )
  end

  def ♥︎
    hide_navbar
    render 'rsvp'
  end
end
