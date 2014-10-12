class Admin::CategoriesController < Admin::BaseController
  include ::Concerns::Crud

  helper_method :category
  helper_method :categories
  respond_to :html

  def index
    @collection = PaginatedCollectionDecorator.decorate(collection.page(params[:page]))
  end

  private

  def category
    resource
  end

  def categories
    collection
  end

  def namespace
    [:admin]
  end

  def resource_params
    params.require(:category).permit(:name, :colour)
  end
end

