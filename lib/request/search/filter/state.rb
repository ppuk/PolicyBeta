module Request
  module Search
    module Filter

      class State < Request::Search::Filter::Base
        def display_value
          I18n.t(@ref, scope: 'activerecord.attributes.policy.states')
        end

        def html_options
          {
            class: "btn btn-xs #{@ref}"
          }
        end
      end

    end
  end
end
