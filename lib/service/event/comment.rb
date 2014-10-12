module Service
  module Event
    class Comment < Service::Event::Base
      attr_accessor :comment

      def initialize(comment)
        @comment = comment
      end

      def created
        log 'comment.created'
        log "comment.created.user.#{comment.user_id}"
      end
    end
  end
end
