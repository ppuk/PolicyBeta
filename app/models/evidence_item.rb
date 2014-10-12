class EvidenceItem < ActiveRecord::Base
  acts_as_votable

  belongs_to :policy
  belongs_to :submitter, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :submitter, presence: true

  def commentable?
    policy.commentable?
  end
end
