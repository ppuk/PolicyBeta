class Api::V1::VotesController < Api::V1::BaseController
  restrict_to :user, :admin

  def create
    if vote_register.perform
      render json: vote_register.vote, serializer: serializer
    else
      head status: 422
    end
  end


  protected

  def vote_register
    @vote_register ||= Service::Vote::Register.new(
      vote_flag: params[:upvote],
      item_type: params[:type].to_s,
      item_id: params[:id].to_i,
      user: current_user
    )
  end

  def serializer
    vote_register.serializer
  end

end
