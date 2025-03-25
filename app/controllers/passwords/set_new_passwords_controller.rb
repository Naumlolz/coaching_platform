# frozen_string_literal: true

# class for setting up new users password
class Passwords::SetNewPasswordsController < ApplicationController
  def show
    assign_email_from_params
  end

  def create
    assign_email_from_params

    set_new_password
    success_password_change
  rescue ServiceError => error
    handle_validation_error(error)
  end

  private

  def assign_email_from_params
    @email = params[:email]
  end

  def handle_validation_error(error)
    flash.now[:error] = error.message
    render 'passwords/set_new_passwords/show'
  end

  def set_new_password
    Passwords::SetNewPasswordService.new(
      email: params[:email],
      new_password: params[:new_password],
      new_password_confirmation: params[:new_password_confirmation]
    ).perform
  end

  def success_password_change
    flash[:success] = 'Password was successfully changed'
    redirect_to sign_in_path
  end
end
