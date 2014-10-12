class Api::V1::ProfileController < Api::V1::BaseController
  restrict_to :user, :admin

  def show
    render json: current_user, serializer: serializer
  end


  def update
    if current_user.update_attributes(user_params)
      render json: current_user, serializer: serializer
    else
      respond_with_validation_errors(current_user)
    end
  end

  def destroy
    if current_user.destroy
      render json: {}
    else
      respond_with_validation_errors(current_user)
    end
  end

  protected

  def serializer
    Api::V1::ProfileSerializer
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
