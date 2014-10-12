module Service
  module Event
    class Mail < Service::Event::Base
      attr_accessor :kind

      def self.delivered_email(message)
        new(kind: message[:stats_key])
      end

      def initialize(opts = {})
        @kind = opts[:kind].to_s
      end

      def create
        log 'mail'
        log "mail.#{@kind}" unless @kind.blank?
      end
    end
  end
end
