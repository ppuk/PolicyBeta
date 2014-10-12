module AccessScope
  module Scope

    class User < AccessScope::Scope::Base
      def editable_evidence_items
        user.evidence_items
      end

      def editable_policies
        user.policies
      end
    end

  end
end

