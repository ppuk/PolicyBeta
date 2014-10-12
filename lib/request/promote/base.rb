module Request
  module Promote

    class Base
      attr_accessor :policy, :user

      delegate :request, :approve, :decline, to: :fm

      def initialize(policy, user)
        @policy = policy
        @user = user
      end

      def current_state
        policy.promotion_state.to_sym
      end

      def fm
        promoter = self

        @fm ||= FiniteMachine.define initial: current_state do
          target promoter

          events {
            event :request, :waiting => :admin_requested, if: ->{ target.is_admin? }
            event :request, :waiting => :user_requested, if: ->{ target.is_user? }

            event :approve, :admin_requested => :approved, if: ->{ target.is_user? }
            event :approve, :user_requested => :approved, if: ->{ target.is_admin? }

            event :decline, :admin_requested => :declined, if: ->{ target.is_user? }
            event :decline, :user_requested => :declined, if: ->{ target.is_admin? }

            event :reset, :any => :waiting, silent: true
          }

          callbacks {
            on_after(:request) { target.perform_request }
            on_after(:approve) { target.perform_approved }
            on_after(:decline) { target.perform_declined }
          }
        end
      end

      def update_state
        state = fm.current
        policy.update_attribute(:promotion_state, state)
      end

      def is_admin?
        user.is_admin?
      end

      def is_user?
        policy.submitter_id == user.id || !is_admin?
      end


      def promote_policy!
        return unless policy.promotable?
        new_state = Policy::INCOMPLETE_STATES[Policy::INCOMPLETE_STATES.index(policy.state) + 1]
        policy.update_attribute(:state, new_state)
      end

      def admins
        User.where(role: 'admin')
      end

      def send_to_admins(message)
        admins.each do |admin|
          SendPolicyMail.perform_async(message, policy.id, admin.id, user.id)
        end
      end

      def send_to_user(message)
        SendPolicyMail.perform_async(message, policy.id, policy.submitter_id, user.id)
      end

      def perform_request
        if is_admin?
          send_to_user(:promotion_request)
        else
          send_to_admins(:promotion_request)
        end

        update_state
      end

      def perform_approved
        promote_policy!

        if is_admin?
          send_to_user(:promotion_accepted)
        else
          send_to_admins(:promotion_accepted)
        end

        # Reset the state
        fm.reset
        update_state
      end

      def perform_declined
        if is_admin?
          send_to_user(:promotion_declined_by_admin)
        else
          send_to_admins(:promotion_declined_by_user)
        end

        # Reset the state
        fm.reset
        update_state
      end
    end

  end
end
