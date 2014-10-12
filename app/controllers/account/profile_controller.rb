class Account::ProfileController < Account::BaseController
  helper_method :user

  def update
    if user.update_attributes(user_params)
      flash[:success] = I18n.t('flash.user.update.success')
      redirect_to account_profile_path
    else
      flash[:warning] = I18n.t('flash.user.update.failure')
      render :edit
    end
  end

  def destroy
    if user.destroy
      flash[:success] = I18n.t('flash.user.destroy.success')
      redirect_to root_path
    else
      flash[:warning] = I18n.t('flash.user.destroy.failure')
      redirect_to account_profile_path
    end
  end

  def soft_delete
    if Service::User::SoftDelete.new(user).process
      flash[:success] = I18n.t('flash.user.soft_delete.success')
    else
      flash[:warning] = I18n.t('flash.user.soft_delete.failure')
    end

    sign_out
    redirect_to root_path(user)
  end

  private

  def user
    current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
