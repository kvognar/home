class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: :api_key_given?
  skip_before_action :verify_authenticity_token, if: :api_key_given?

  def api_key_given?
    params[:api_key] == ENV['TRANSFIGURATION_KEY']
  end

  def current_user
    return @current_user if @current_user.present?
    current_session = Session.find_by(session_token: cookies.permanent[:token])
    @current_user = current_session.user if current_session.present?
    @current_user
  end

  def signed_in?
    current_user != nil
  end

  def sign_in!(user)
    new_session = Session.create!(user: user)
    cookies.permanent[:token] = new_session.session_token
  end

  def sign_out!
    Session.where(user: current_user).destroy_all
    @current_user = nil
    cookies.permanent[:token] = nil
  end

  def require_admin!
    redirect_to days_url unless signed_in? &&  current_user.is_admin
  end

  def require_signed_in!
    redirect_to days_url unless signed_in?
  end

  def hide_navbar
    @hide_navbar = true
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def admin?
    current_user&.is_admin
  end

  helper_method :signed_in?
  helper_method :admin?
  helper_method :current_user

end
