module Request
  module Search

    class Policy < Base
      attribute :category, String
      attribute :state, String
      attribute :submitter_id, Integer
      attribute :order_name, String

      def self.permitted_params
        [:query, :page, :category, :order_name, :state]
      end

      def self.search(params, user = nil)
        search_params = {}
        params = ActionController::Parameters.new(params)

        if params[:search]
          search_params = params.permit(search: permitted_params)[:search]
        end

        search_params.merge!(submitter_id: user.id) if user
        new(search_params)
      end

      def search_attributes
        super + [:query_string, :order, :submitter, :category_name, :state_name]
      end

      def index
        ::PoliciesIndex
      end

      def query_string
        index.query(query_string: {
          default_field: :title,
          query: query,
          default_operator: 'AND'
        }) if query.present?
      end


      def available_orders
        {
          created_asc: { created_at: :asc },
          created_desc: { created_at: :desc },
          votes_asc: { cached_votes_score: :asc },
          votes_desc: { cached_votes_score: :desc }
        }.with_indifferent_access
      end

      def order
        order_attr = available_orders[order_name] || { cached_votes_score: :desc }
        index.order(order_attr)
      end

      def submitter
        _submitter_id = submitter_id
        index.filter{ must(submitter_id == _submitter_id) } if submitter_id.present?
      end

      def category_name
        _category = category
        index.filter{ must(category == _category) } if category.present?
      end

      def state_name
        _state = state
        index.filter{ must(state == _state) } if state.present?
      end

      def state_facet
        { state: {terms: {field: :state} } }
      end

      def category_facet
        { category: {terms: {field: :category} } }
      end

      def facet_attributes
        [:category_facet, :state_facet]
      end

      def filters
        [:category, :state]
      end

    end

  end
end
