class PolicyMailer < BaseMailer

  def policy_accepted(policy_id)
    @policy = Policy.find(policy_id)
    @to = @policy.submitter

    mail stats_key: 'policy_accepted',
         to: @to.email,
         subject: I18n.t(
           :subject,
           scope: [:policy_mailer, :policy_accepted]
         )
  end

  def policy_declined(policy_id)
    @policy = Policy.find(policy_id)
    @to = @policy.submitter

    mail stats_key: 'policy_declined',
         to: @to.email,
         subject: I18n.t(
           :subject,
           scope: [:policy_mailer, :policy_declined]
         )
  end

  def promotion_request(policy_id, to_id, from_id)
     send_message(policy_id, to_id, from_id, :promotion_request)
  end

  def promotion_declined_by_admin(policy_id, to_id, from_id)
     send_message(policy_id, to_id, from_id, :promotion_declined_by_admin)
  end

  def promotion_declined_by_user(policy_id, to_id, from_id)
     send_message(policy_id, to_id, from_id, :promotion_declined_by_user)
  end

  def promotion_accepted(policy_id, to_id, from_id)
     send_message(policy_id, to_id, from_id, :promotion_accepted)
  end

  private

  def send_message(policy_id, to_id, from_id, message)
    @to = User.find(to_id)
    @from = User.find(from_id)
    @policy = Policy.find(policy_id)

    mail stats_key: message.to_s,
         to: @to.email,
         subject: I18n.t(
           :subject,
           scope: [:policy_mailer, message]
         )
  end
end
