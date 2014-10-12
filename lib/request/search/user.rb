module Request
  module Search

    class User < Base
      def search_attributes
        super + [:query_string]
      end

      def index
        ::UsersIndex
      end

      def query_string
        index.query(query_string: {
          query: query,
          default_operator: 'AND'
        }) if query
      end
    end

  end
end
