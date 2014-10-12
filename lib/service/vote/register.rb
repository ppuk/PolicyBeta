module Service
  module Vote

    class Register < Service::Base
      attribute :vote_flag, Boolean
      attribute :item_type, String
      attribute :item_id,   Integer
      attribute :user,      ::User

      def process
        if vote
          # voting the same way twice nullifies the vote
          # i.e. the user has voted in error
          if vote.vote_flag == vote_flag
            nullify_vote
          else
            # Clear the existing vote if it exists, and
            # cast a new one
            remove_vote
            cast_vote
          end
        else
          # Just cast the first vote
          cast_vote
        end

        true
      end

      def vote
        @vote ||= item.votes_for.where(voter: user).first
      end

      def valid?
        !item_class.nil?
      end

      def serializer
        "Api::V1::#{item_class.to_s}VoteSerializer".constantize
      end

      private

      def item
        @item ||= item_class.find(item_id)
      end

      def item_class
        case item_type
        when 'policy'
          ::Policy
        when 'comment'
          ::Comment
        when 'evidence_item'
          ::EvidenceItem
        end
      end

      def nullify_vote
        vote.update_attribute(:vote_flag, nil)
        item.update_cached_votes
        @vote = nil
      end

      def remove_vote
        vote.destroy
        @vote = nil
      end

      def upvote?
        !!vote_flag
      end

      def cast_vote
        if upvote?
          user.likes item
        else
          user.dislikes item
        end

        @vote = nil

        true
      end
    end

  end
end
