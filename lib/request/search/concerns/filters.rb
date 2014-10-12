module Request
  module Search
    module Concerns

      module Filters

        def filters
          []
        end

        # True if any filters have been applied
        def filtered?
          applied_filters.any?
        end

        # Returns a hash of filters that may be used with the current search
        # request. Contains the filter parameter name as the key and an array
        # of valid values. Note the values are populated from the search facets
        # so that only values that will return results are given. The values are
        # further encapsulated in the Request::Search::Filter classes to help
        # when displaying them on the FE
        def available_filters
          return @available_filters if @available_filters
          @available_filters = {}

          filters.each do |filter|
            if available_facet = search_with_facets.facets[filter.to_s]
              if applied_filters[filter].nil?
                @available_filters[filter] = available_facet['terms'].inject([]) do |data, term|
                  data << Request::Search::Filter::Base.init(term, filter)
                end
              end
            end
          end

          @available_filters
        end

        # returns an array of hashes in the form:
        # [{filter_name: 'value'}]
        def applied_filters
          return @applied_filters if @applied_filters

          @applied_filters = {}

          filters.each do |filter|
            value = self.send(filter)

            if value.present?
              @applied_filters[filter] = Request::Search::Filter::Base.init(value, filter)
            end
          end

          @applied_filters
        end
      end

    end
  end
end
