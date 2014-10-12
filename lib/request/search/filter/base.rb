module Request
  module Search
    module Filter

      class Base
        def self.init(term, type)
          klass = case type
          when :category
            Request::Search::Filter::Category
          when :state
            Request::Search::Filter::State
          else
            raise "Unknown filter #{type}"
          end

          if term.is_a?(Hash)
            klass.new(term['term'], term['count'])
          else
            klass.new(term.downcase)
          end
        end

        def initialize(reference, count = nil)
          @ref = reference
          @count = count
        end

        def value
          display_value.downcase
        end

        def display_value
          @ref
        end

        def value_with_count
          "#{display_value} x #{@count}"
        end

        def html_options
          {}
        end
      end

    end
  end
end
