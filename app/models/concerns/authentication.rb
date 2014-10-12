module Concerns
  module Authentication
    extend ActiveSupport::Concern

    included do
      include Clearance::User

      before_validation :normalize_username

      def normalize_username
        self.username = self.class.normalize(username)
      end

      def email_optional?
        true
      end

      def self.authenticate(email, password)
        if user = find_by_normalized_email_or_username(email)
          if password.present? && user.authenticated?(password) && !user.deleted?
            return user
          end
        end
      end

      def self.find_by_normalized_email_or_username(ident)
        ident = normalize(ident)
        where(["email = ? OR username = ?", ident, ident]).first
      end

      def self.normalize(ident)
        ident.to_s.downcase.gsub(/\s+/, "")
      end
    end
  end
end


