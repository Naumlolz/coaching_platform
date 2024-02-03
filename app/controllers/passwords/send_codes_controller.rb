class Passwords::SendCodesController < ApplicationController
  def create
    @email = params[:email]

    Passwords::SendCodeService.new(
      email: params[:email]
    ).perform
    flash[:success] = 'Code has been sent on your email'
    redirect_to passwords_send_code_path(email: @email)
    rescue ServiceError => e
      flash.now[:error] = e.message
      render 'users/forget_password'
  end

  def show
    byebug
    @email = params[:email]
  end
end