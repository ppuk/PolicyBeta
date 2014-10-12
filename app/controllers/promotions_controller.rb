class PromotionsController < ApplicationController
  before_action :require_l2_user

  def request_promotion
    promoter.request
    redirect_back
  end

  def approve_promotion
    promoter.approve
    redirect_back
  end

  def decline_promotion
    promoter.decline
    redirect_back
  end

  private

  def redirect_back
    redirect_to :back
  end

  def policy
    @policy ||= scope.editable_policies.find(params[:id])
  end

  def promoter
    @promoter ||= Request::Promote::Base.new(policy, current_user)
  end
end
