class Passwords::SendCodesController < ApplicationController
  def create
  end

  def show
    Passwords::SendCodeService.new(
      email: params[:email]
    ).perform
    flash[:success] = 'Code has been sent on your email'
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'users/forget_password'
  end
end