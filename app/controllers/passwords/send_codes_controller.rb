# frozen_string_literal: true

# class for sending 6-digit code to users email
class Passwords::SendCodesController < ApplicationController
  def create
    email = params[:email]

    Passwords::SendCodeService.new(email: email).perform
    handle_success(email)
  rescue ServiceError => error
    handle_error(error)
  end

  private

  def handle_success(email)
    flash[:success] = 'Code has been sent on your email'
    redirect_to passwords_validate_code_path(email: email)
  end

  def handle_error(error)
    flash.now[:error] = error.message
    render 'users/forget_password'
  end
end
