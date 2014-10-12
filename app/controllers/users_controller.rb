class UsersController < Clearance::UsersController

  def new
    @user = User.new
  end

  def create
    creator = Service::User::Create.new(user_params)

    if creator.perform
      sign_in creator.user
      redirect_to root_path
    else
      @user = creator.user
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
