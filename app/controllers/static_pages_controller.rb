class StaticPagesController < ApplicationController
  def home
  end
  
  def resume
    send_file(
    "#{Rails.root}/public/resume.pdf",
    filename: "resume.pdf",
    type: "application/pdf"
    )
  end
end
