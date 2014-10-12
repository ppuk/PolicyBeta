module AccessScope

  class Base
    delegate :users, :editable_policies, :policies, :categories, :editable_evidence_items, to: :@scope

    def initialize(user)
      if User::VALID_ROLES.include?(user.role)
        scope_class = "AccessScope::Scope::#{user.role.camelize}".constantize
      else
        scope_class = AccessScope::Scope::Base
      end

      @scope = scope_class.new(user)
    end
  end

end

