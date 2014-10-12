module Request
  module Search
    module Concerns

      module Search
        def search_attributes
          []
        end

        def index
          raise 'Invalid search model'
        end

        def perform
          search.only(:id).page(page).load
        end

        def components
          search_attributes.inject([]) { |data, attr| data << send(attr) }
        end

        def search
          components.compact.reduce(:merge) || index
        end
      end

    end
  end
end
