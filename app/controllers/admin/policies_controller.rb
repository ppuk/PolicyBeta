class Admin::PoliciesController < Admin::BaseController
  include ::Concerns::Crud

  helper_method :policy
  helper_method :policies
  respond_to :html

  def index
    @search = Request::Search::Policy.search(params)
    @facets = @search.search_with_facets.facets
    @collection = PaginatedCollectionDecorator.decorate(@search.search_with_facets)
  end

  def accept
    if Service::Policy::Accept.new(policy: policy).perform
      flash[:success] = t('flash.policy.accepted')
    else
      flash[:danger] = t('flash.policy.not_accepted')
    end

    redirect_to admin_policy_path(policy)
  end

  def decline
    if Service::Policy::Decline.new(policy: policy).perform
      flash[:success] = t('flash.policy.declined')
    else
      flash[:danger] = t('flash.policy.not_declined')
    end

    redirect_to admin_policy_path(policy)
  end

  private

  def before_create
    resource.submitter = current_user
  end

  def policy
    resource
  end

  def policies
    collection
  end

  def namespace
    [:admin]
  end

  def resource_params
    params.require(:policy).permit(:title, :description, :category_id, :submitter_id, :tag_list, :state)
  end
end
