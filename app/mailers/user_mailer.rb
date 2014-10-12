class UserMailer < BaseMailer

  def welcome(user_id)
    @user = User.find(user_id)
    mail stats_key: 'welcome',
         to: @user.email,
         subject: I18n.t(
           :subject,
           scope: [:user_mailer, :welcome]
         )
  end

  def confirm_email(user_id)
    @user = User.find(user_id)
    mail stats_key: 'confirm_email',
         to: @user.email,
         subject: I18n.t(
           :subject,
           scope: [:user_mailer, :confirm_email]
         )
  end

  def change_password(user_id)
    @user = User.find(user_id)
    mail stats_key: 'change_password',
         to: @user.email,
         subject: I18n.t(
           :subject,
           scope: [:user_mailer, :change_password]
         )
  end

end
