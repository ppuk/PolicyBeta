module Concerns
  module Roles
    extend ActiveSupport::Concern

    included do
      VALID_ROLES = %w(admin user)

      validates_presence_of :role, allow_blank: false
      validates_inclusion_of :role, in: VALID_ROLES
    end

    def is_admin?
      role == 'admin'
    end

    def is_user?
      role == 'user'
    end

    def scopes
      AccessibleScope.new(self)
    end

  end
end

