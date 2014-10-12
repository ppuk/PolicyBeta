module Request
  module Search
    module Concerns

      module Facets

        def facet_attributes
          []
        end

        def facet_components
          fc = facet_attributes.inject([]) { |data, attr| data << send(attr) }
          fc.compact.reduce(:merge) || {}
        end

        def search_with_facets
          @facets ||= search.facets(facet_components).load
        end

      end

    end
  end
end
