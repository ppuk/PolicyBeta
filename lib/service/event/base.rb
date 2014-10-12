module Service
  module Event
    class Base
      private

      def log(event)
        # TODO: Implement StatsD or some form of metric logger
        nil
      end
    end
  end
end
