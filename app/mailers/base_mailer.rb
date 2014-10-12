class BaseMailer < ActionMailer::Base
  layout 'email'
  default from: ENV['DEFAULT_MAIL_FROM_ADDRESS']

  register_observer Service::Event::Mail
end
