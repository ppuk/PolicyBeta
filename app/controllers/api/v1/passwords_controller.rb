class Api::V1::PasswordsController < Api::V1::BaseController

  def create
    find_user_by_email
    @user.forgot_password!
    UserMailer.change_password(@user).deliver
    render nothing: true
  end

  private

  def find_user_by_email
    @user = User.find_by_normalized_email params[:email]
    raise ActiveRecord::RecordNotFound unless @user
  end

end
