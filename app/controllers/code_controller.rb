class CodeController < ApplicationController

  before_action :hide_navbar, except: [:projects, :games, :doodles]
  def projects
  end

  def games
  end

  def doodles
  end

  def fall_from_grace
  end

  def platformer
  end

  def fairy
  end

  def dandelion
  end

  def jeffress_model
  end

  def tweetjam_sea
  end

  def bubble_booper
  end

  def spooky_castle
    response.headers["X-FRAME-OPTIONS"] = "ALLOW-FROM https://app.schoolology.com"
  end
end
