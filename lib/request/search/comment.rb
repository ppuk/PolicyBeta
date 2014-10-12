module Request
  module Search

    class Comment < Base
      def search_attributes
        super + [:query_string]
      end

      def index
        ::CommentsIndex
      end

      def query_string
        index.query(query_string: {
          default_field: :body,
          query: query,
          default_operator: 'AND'
        }) if query
      end
    end

  end
end
