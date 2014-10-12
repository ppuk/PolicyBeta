module Concerns
  module EmailConfirmation
    extend ActiveSupport::Concern

    included do
      attr_accessor :send_confirmation

      scope :confirmed_email, -> { where.not(email_confirmed_on: nil) }
      scope :unconfirmed_email, -> { where(email_confirmed_on: nil) }

      before_create :generate_email_confirmation_token
      before_save :reset_email_confirmation_status
      after_commit :send_email_confirmation_email, if: :send_confirmation
    end

    def reset_email_confirmation_status
      if email_changed?
        generate_email_confirmation_token
        self.email_confirmed_on = nil
        self.send_confirmation = true if persisted?
      end
    end

    def send_email_confirmation_email
      SendUserMail.perform_async(:confirm_email, self.id)
    end

    def email_confirmation_hash_data
      [email, email_confirmation_token, ENV['SECRET_KEY_BASE']].join()
    end

    def email_confirmation_url_token
      data = BCrypt::Password.create(email_confirmation_hash_data)
      Base64.urlsafe_encode64(data)
    end

    def hash_matches?(hash)
      hash = BCrypt::Password.new(Base64.urlsafe_decode64(hash))
      hash == email_confirmation_hash_data
    end

    def generate_email_confirmation_token
      self.email_confirmation_token = Service::User::Confirm.generate_token
    end

    def confirm_email!
      update_column(:email_confirmed_on, Time.now.utc)
    end

    def unconfirm_email!
      update_column(:email_confirmed_on, nil)
    end

    def email_confirmed?
      email.present? && email_confirmed_on.present?
    end

  end
end
