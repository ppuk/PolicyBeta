class Api::V1::CommentsController < Api::V1::BaseController
  restrict_to :user, :admin, except: [:index]

  def index
    @comments = commentable.comments.order(cached_votes_score: :desc).from_root(params[:root_id]).page(params[:page]).per(25)
    render json: @comments, serializer: Api::V1::PaginatedCollectionSerializer, each_serializer: serializer
  end


  def create
    creator = Service::Comment::Create.new(comment_params)
    creator.user = current_user

    if creator.perform
      render json: creator.comment, serializer: serializer
    else
      respond_with_validation_errors(creator)
    end
  end

  protected

  def commentable
    @commentable ||= commentable_class.find(params[:commentable_id])
  end

  def commentable_class
    if Comment::VALID_COMMENTABLE_TYPES.include?(commentable_type)
      commentable_type.constantize
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def commentable_type
    @commentable_type = params[:commentable_type].camelize
  end

  def serializer
    Api::V1::CommentSerializer
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id, :commentable_type, :commentable_id)
  end

end
