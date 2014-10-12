module Requests
  module Api
    module V1
      module JsonHelper

        def recursive_symbolize_keys(h)
          case h
          when Hash
            Hash[
              h.map do |k, v|
                [ k.respond_to?(:to_sym) ? k.to_sym : k, recursive_symbolize_keys(v) ]
              end
            ]
          when Enumerable
            h.map { |v| recursive_symbolize_keys(v) }
          else
            h
          end
        end

        def parsed_response
          data = nil

          if response.is_a? ActionDispatch::TestResponse
            data = JSON.parse(response.body)
          else
            data = response.parsed
          end

          recursive_symbolize_keys(data)
        end

      end
    end
  end
end
