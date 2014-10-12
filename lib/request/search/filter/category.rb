module Request
  module Search
    module Filter

      class Category < Request::Search::Filter::Base
        def self.all_values
          @@all_values ||= ::Category.all.to_a
        end

        def category
          return @category if @category

          index = self.class.all_values.index { |obj| obj.name.downcase == @ref.downcase }
          if index
            @category = (self.class.all_values[index]).decorate
          end

          @category
        end

        def display_value
          category.name
        end

        def html_options
          {
            class: 'btn btn-xs',
            style: "background-color: #{category.colour}; color: #{category.contrasting_color}"
          }
        end
      end

    end
  end
end
