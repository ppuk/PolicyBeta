class Admin::UsersController < Admin::BaseController
  include ::Concerns::Crud

  helper_method :user
  helper_method :users
  respond_to :html

  def show
    @policies = user.policies.decorate
  end

  def impersonate
    sign_in user
    redirect_to root_path
  end

  def confirm_email
    user.confirm_email!
    flash[:success] = I18n.t('flash.user.confirm_email.success')
    redirect_to admin_user_path(user)
  end

  def unconfirm_email
    user.unconfirm_email!
    flash[:success] = I18n.t('flash.user.unconfirm_email.success')
    redirect_to admin_user_path(user)
  end

  def send_password_reset
    if user.email_confirmed?
      user.forgot_password!
      UserMailer.change_password(user).deliver
      flash[:success] = I18n.t('flash.user.password_reset.sent')
    else
      flash[:danger] = I18n.t('flash.user.email_not_confirmed')
    end

    redirect_to admin_user_path(user)
  end

  def soft_delete
    if Service::User::SoftDelete.new(user).process
      flash[:success] = I18n.t('flash.user.soft_delete.success')
    else
      flash[:danger] = I18n.t('flash.user.soft_delete.failure')
    end

    redirect_to admin_user_path(user)
  end

  private

  def namespace
    [:admin]
  end

  def user
    resource
  end

  def users
    collection
  end

  def search_class
    Request::Search::User
  end

  def resource_params
    params.require(:user).permit(:username, :email, :password, :banned_until, :role)
  end

end
