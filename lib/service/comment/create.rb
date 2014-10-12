module Service
  module Comment
    class Create < Service::Base
      attribute :body,             String
      attribute :commentable_id,   Integer
      attribute :commentable_type, String
      attribute :parent_id,        Integer, default: nil

      attr_accessor :user

      delegate :as_json, :errors, :valid?, to: :comment

      def commentable
        commentable_class.constantize.find(commentable_id)
      end

      def comment
        @comment ||= commentable.comments.build({
          user: user,
          body: body,
          parent_comment_id: parent_id
        })
      end

      def commentable_class
        @commentable_class ||= commentable_type.camelize
      end

      def parent_exists?
        return true if parent_id.nil?
        commentable.comments.find(parent_id).present?
      end

      def valid?
        ::Comment::VALID_COMMENTABLE_TYPES.include?(commentable_class) &&
          commentable &&
          commentable.commentable? &&
          parent_exists? &&
          comment.valid?
      end

      def process
        if valid? && comment.save
          ::Service::Event::Comment.new(comment).created
        else
          return false
        end

        true
      end
    end

  end
end
