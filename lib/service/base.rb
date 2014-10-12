module Service

  class Base
    include Virtus.model

    def perform
      valid? ? process : false
    end

    protected

    def process
      raise NotImplemented, "process should be implemented"
    end
  end

end
