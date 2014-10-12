module AccessConstraint
  class Admin < AccessConstraint::Base
    def has_access?
      current_user.is_admin?
    end
  end
end
