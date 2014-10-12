module Api::V1::Concerns

  module ValidationErrors
    extend ActiveSupport::Concern

    included do
      protected

      # For error message reporting, we need to override
      # the default locale so that the error messages are
      # the correct values (i.e. not human-readable strings)
      def errors_locale(&block)
        @previous_locale = I18n.locale
        I18n.locale = :json

        yield

        I18n.locale = @previous_locale
      end

      def respond_with_validation_errors(object)
        errors_locale do
          object.valid?
        end

        error_array = object.errors.zip.flatten(1).inject([]) do |errors, error|
          errors << {error[0] => error[1]}
        end

        render json: {
          message: 'Unprocessable Entity',
          errors: error_array
        }, status: 422
      end
    end
  end

end
