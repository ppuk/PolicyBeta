module Concerns
  module PolicyState
    extend ActiveSupport::Concern

    COMPLETE_STATES = %w(passed rejected)
    INCOMPLETE_STATES = %w(suggestion proposition vote)
    VALID_STATES = INCOMPLETE_STATES + COMPLETE_STATES

    included do
      validates :state, inclusion: VALID_STATES
    end


    def promotable?
      %w(suggestion proposition).include?(state)
    end

    def editable?
      state == 'suggestion'
    end

    def receiving_evidence?
      state == 'proposition'
    end

    def commentable?
      %w(suggestion proposition).include?(state)
    end

    def waiting?
      promotion_state == 'waiting'
    end

    def admin_requested?
      promotion_state == 'admin_requested'
    end
  end
end
