class ErrorsController < ApplicationController
  layout 'exception'

  before_action :error_is_valid?

  VALID_ERRORS = [
    404,
    422,
    500
  ]

  def show
    respond_to do |format|
      format.html { render "errors/#{error_code}", status: error_code }
      format.js { render json: '{}', status: error_code }
    end
  end

  private

  def error_code
    @error_code ||= params[:status].to_i
  end

  def error_is_valid?
    raise RuntimeError unless VALID_ERRORS.include?(error_code)
  end
end
