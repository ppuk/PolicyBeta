module Request
  module Search

    class Base
      include Virtus::Model

      include Request::Search::Concerns::Search
      include Request::Search::Concerns::Facets
      include Request::Search::Concerns::Filters

      attribute :query, String
      attribute :page, Integer

      def self.permitted_params
        [:query, :page]
      end

      def self.search(params)
        search_params = {}

        if params[:search]
          search_params = params.permit(search: permitted_params)[:search]
        end

        new(search_params)
      end
    end

  end
end
