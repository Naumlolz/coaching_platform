# frozen_string_literal: true

# class for validating 6-digit code according to users email
class Passwords::ValidateCodesController < ApplicationController
  def create
    @email = params[:email]
    Passwords::ValidateCodeService.new(
      otp_code: params[:otp_code],
      email: params[:email]
    ).perform
    redirect_to passwords_set_new_password_path
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'passwords/validate_codes/show'
  end

  def show
    @email = params[:email]
  end
end
