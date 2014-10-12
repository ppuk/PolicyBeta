class Comment < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  belongs_to :parent_comment, class_name: 'Comment', counter_cache: true
  belongs_to :commentable, polymorphic: true, counter_cache: true

  has_many :replies, class_name: 'Comment', foreign_key: :parent_comment_id

  validates :body, presence: true
  validates :commentable, presence: true
  validates :user, presence: true

  VALID_COMMENTABLE_TYPES = [
    'Policy',
    'Comment',
    'EvidenceItem'
  ]

  def self.from_root(root_id)
    where(parent_comment: root_id)
  end

end
