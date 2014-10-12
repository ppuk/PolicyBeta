class Api::V1::BaseController < ActionController::Base

  include Api::V1::Concerns::AccessRestriction
  include Api::V1::Concerns::ExceptionHandling
  include Api::V1::Concerns::ValidationErrors
  include Api::V1::Concerns::Pagination

  skip_before_filter :verify_authenticity_token
  respond_to :json
  layout nil

  serialization_scope :view_context

end
