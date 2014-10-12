class Policy < ActiveRecord::Base
  include Concerns::PolicyState

  acts_as_votable
  acts_as_taggable

  belongs_to :submitter, class_name: 'User'
  belongs_to :category
  belongs_to :previous_version, class_name: 'Policy'

  has_many :next_versions, class_name: 'Policy', foreign_key: :previous_version_id
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :evidence_items, ->{ order(cached_votes_score: :desc) }, dependent: :destroy

  update_index('policies#policy', :self, urgent: true)
  update_index('tags', :tags, urgent: true)

  validates :title, presence: true
  validates :description, presence: true
  validates :submitter, presence: true
  validates :category, presence: true
end
