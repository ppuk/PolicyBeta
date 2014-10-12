module Request
  module Search

    class Tag < Base
      def search_attributes
        super + [:query_string, :order]
      end

      def index
        ::TagsIndex
      end

      def query_string
        index.query(query_string: {
          default_field: :name,
          query: query + '*',
          default_operator: 'AND'
        }) if query
      end

      def order
        index.order(name: :desc)
      end
    end

  end
end
