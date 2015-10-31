class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: :api_key_given?
  skip_before_action :verify_authenticity_token, if: :api_key_given?

  def api_key_given?
    puts "HEY HEY HEY HEY HEY HEY HEY"
    params[:api_key] == ENV['TRANSFIGURATION_KEY']
  end

end
