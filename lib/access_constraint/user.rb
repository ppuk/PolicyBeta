module AccessConstraint
  class User < AccessConstraint::Base
    def has_access?
      true
    end
  end
end
