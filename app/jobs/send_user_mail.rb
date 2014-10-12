class SendUserMail < BaseJob
  def perform(email_type, *opts)
    UserMailer.send(email_type, *opts).deliver
  end
end

