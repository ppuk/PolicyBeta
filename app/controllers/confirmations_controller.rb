class ConfirmationsController < ApplicationController

  def show
    if Service::User::Confirm.new(confirmation_params).perform
      render 'email_confirmed'
    else
      render 'email_not_confirmed'
    end
  end

  protected

  def confirmation_params
    params.permit(:id, :token, :email_hash)
  end

end
