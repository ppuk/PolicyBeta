class Api::V1::TagsController < Api::V1::BaseController
  restrict_to :user, :admin

  def index
    @search = Request::Search::Tag.new(search_params)
    render json: @search.perform, serializer: serializer
  end

  protected

  def search_params
    params.permit(:query)
  end

  def serializer
    Api::V1::PaginatedCollectionSerializer
  end

end
