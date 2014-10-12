Clearance.configure do |config|
  config.mailer_sender = ENV['DEFAULT_MAIL_FROM_ADDRESS']
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
end
