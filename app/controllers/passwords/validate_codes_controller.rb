# frozen_string_literal: true

# class for validating 6-digit code according to users email
class Passwords::ValidateCodesController < ApplicationController
  def show
    assign_email_from_params
  end

  def create
    assign_email_from_params
    validate_otp_code
    redirect_to passwords_set_new_password_path(email: assign_email_from_params)
  rescue ServiceError => error
    handle_validation_error(error)
  end

  private

  def assign_email_from_params
    @email = params[:email]
  end

  def validate_otp_code
    Passwords::ValidateCodeService.new(
      otp_code: params[:otp_code],
      email: params[:email]
    ).perform
  end

  def handle_validation_error(error)
    flash.now[:error] = error.message
    render 'passwords/validate_codes/show'
  end
end
