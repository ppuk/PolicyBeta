class Api::V1::UsersController < Api::V1::BaseController

  def create
    creator = Service::User::Create.new(user_params)

    if creator.perform
      render json: creator.user, serializer: serializer
    else
      respond_with_validation_errors(creator.user)
    end
  end

  protected

  def serializer
    Api::V1::ProfileSerializer
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
