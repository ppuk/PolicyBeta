class User < ActiveRecord::Base
  include Concerns::Authentication
  include Concerns::EmailConfirmation
  include Concerns::Roles

  acts_as_voter

  has_many :ip_logs, dependent: :destroy
  has_many :policies, foreign_key: :submitter_id
  has_many :evidence_items, foreign_key: :submitter_id

  update_index('users#user', :self, urgent: true)

  validates :username, uniqueness: true, presence: true
  validates :email,
    uniqueness: { allow_blank: true },
    email: { strict_mode: true, allow_blank: true }


  def banned?
    banned_until.present? && banned_until > Time.now.utc
  end

  # True if this record has been soft deleted
  def deleted?
    deleted_at.present? && deleted_at < Time.now.utc
  end
end
