class Account::EvidenceItemsController < Account::BaseController
  include ::Concerns::Crud

  helper_method :evidence_item
  helper_method :evidence_items
  helper_method :policy
  respond_to :html

  before_action :require_l2_user, :receiving_evidence

  private

  def receiving_evidence
    if !policy.receiving_evidence?
      flash[:danger] = t('cannot_add_evidence', scope: 'flash.evidence_item')
      redirect_to [policy]
    end
  end

  def before_create
    resource.submitter = current_user
    resource.policy = policy
  end

  def url_after_create
    [policy]
  end

  def url_after_update
    [policy]
  end

  def url_after_destroy
    [policy]
  end

  def collection
    @collection ||= scope.editable_evidence_items
  end

  def evidence_item
    resource
  end

  def evidence_items
    collection
  end

  def namespace
    [:account, policy]
  end

  def policy
    Policy.find(params[:policy_id])
  end

  def resource_params
    params.require(:evidence_item).permit(:title, :description)
  end
end


