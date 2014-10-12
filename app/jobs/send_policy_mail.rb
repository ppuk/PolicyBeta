class SendPolicyMail < BaseJob
  def perform(email_type, *opts)
    PolicyMailer.send(email_type, *opts).deliver
  end
end

