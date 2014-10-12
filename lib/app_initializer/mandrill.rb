module AppInitializer

  class Mandrill < Base
    private

    def init
      setup_smtp
      set_delivery_method
    end

    def setup_smtp
      ActionMailer::Base.smtp_settings = {
        :port =>           '587',
        :address =>        'smtp.mandrillapp.com',
        :user_name =>      ENV['MANDRILL_USERNAME'],
        :password =>       ENV['MANDRILL_APIKEY'],
        :authentication => :plain
      }
    end

    def set_delivery_method
      ActionMailer::Base.delivery_method = :smtp
    end

    def enabled?
      !%w(development test).include? Rails.env
    end
  end

end

