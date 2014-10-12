module AccessScope
  module Scope

    class Admin < AccessScope::Scope::Base
      def users
        ::User
      end

      def editable_evidence_items
        ::EvidenceItem
      end

      def editable_policies
        ::Policy
      end

      def categories
        ::Category
      end

      def policies
        ::Policy
      end
    end

  end
end

