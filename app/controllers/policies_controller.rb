class PoliciesController < ApplicationController
  helper_method :policy
  helper_method :policies

  attr_accessor :policies

  def index
    @search = Request::Search::Policy.search(params)
    @policies = PaginatedCollectionDecorator.decorate(@search.search_with_facets)
  end

  def show
  end

  protected

  def policy
    @policy ||= Policy.find(params[:id]).decorate
  end
end
