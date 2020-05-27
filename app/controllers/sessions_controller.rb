class SessionsController < ApplicationController
  before_action :require_signed_in!, only: :destroy

  def new
  end

  def create
    @user = User.admin
    if @user.is_password?(params[:secret])
      sign_in!(@user)
      redirect_to days_url
    else
      flash[:error] = "Who are you?"
      redirect_to days_url
    end
  end

  def destroy
    sign_out!
    flash[:success] = "Goodbye~"
    redirect_to days_url
  end
end
