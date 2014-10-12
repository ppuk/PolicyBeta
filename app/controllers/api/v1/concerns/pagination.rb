module Api::V1::Concerns

  module Pagination
    extend ActiveSupport::Concern

    MAX_PER_PAGE_PAGINATION = 1000
    DEFAULT_PER_PAGE_PAGINATION = 50

    included do
      protected

      def per_page_param
        per_page = (params[:per_page] || DEFAULT_PER_PAGE_PAGINATION).to_i
        per_page = MAX_PER_PAGE_PAGINATION if per_page > MAX_PER_PAGE_PAGINATION
        per_page
      end

      def page_param
        params[:page].to_i
      end

    end
  end

end
