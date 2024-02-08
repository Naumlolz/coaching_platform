# frozen_string_literal: true

# class for setting up new users password
class Passwords::SetNewPasswordsController < ApplicationController
  def create
    @email = params[:email]

    Passwords::SetNewPasswordService.new(
      email: params[:email],
      new_password: params[:new_password],
      new_password_confirmation: params[:new_password_confirmation]
    ).perform
    flash[:success] = 'Password was successfully changed'
    redirect_to sign_in_path
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'passwords/set_new_passwords/show'
  end

  def show
    @email = params[:email]
  end
end
