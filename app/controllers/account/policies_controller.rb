class Account::PoliciesController < Account::BaseController
  include ::Concerns::Crud

  helper_method :policy
  helper_method :policies
  respond_to :html

  before_action :require_l2_user
  before_action :ensure_editable, only: [:edit, :update]

  def index
    @search = Request::Search::Policy.search(params, current_user)
    @collection = PaginatedCollectionDecorator.decorate(@search.search_with_facets)
  end


  private

  def ensure_editable
    if !policy.editable?
      flash[:danger] = t('cannot_edit_policy', scope: 'flash.policy')
      redirect_to policy_path(policy)
    end
  end

  def before_create
    resource.submitter = current_user
  end

  def collection
    @collection ||= scope.editable_policies
  end

  def policy
    resource
  end

  def policies
    collection
  end

  def namespace
    [:account]
  end

  def resource_params
    params.require(:policy).permit(:title, :description, :category_id, :tag_list)
  end
end

