class PasswordsController < Clearance::PasswordsController

  private

  def deliver_email(user)
    SendUserMail.perform_async(:change_password, user.id)
  end

  def url_after_update
    Service::Event::User.new(current_user).password_reset
    super
  end

  private

  def find_user_for_create
    User.confirmed_email.find_by_normalized_email params[:password][:email]
  end
end
