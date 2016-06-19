class StaticPagesController < ApplicationController
  def home
    @day = Day.includes(:photo_of_the_day).last
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
end
