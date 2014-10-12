class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :policies

  before_destroy :ensure_no_policies_are_associated

  def ensure_no_policies_are_associated
    if policies.any?
      errors.add(:base, I18n.t('cannot_delete_with_policies', scope: 'activerecord.errors.category'))
      return false
    end

    true
  end
end
