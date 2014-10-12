module Concerns

  module AtomicChewy
    extend ActiveSupport::Concern

    included do
      # Atomicity
      #
      # We still have one lingering problem. If we do something like
      # books.map(&:save) to save multiple books, we’ll request an update of the
      # entertainment index every time an individual book is saved. Thus, if we
      # save five books, we’ll update the Chewy index five times. This behavior is
      # acceptable for REPL, but certainly not acceptable for controller actions
      # in which performance is critical.
      #
      # We address this issue with the Chewy.atomic block:
      #
      # class ApplicationController < ActionController::Base
      #   around_action { |&block| Chewy.atomic(&block) }
      # end
      #
      # In short, Chewy.atomic batches these updates as follows:
      #
      # 1. Disables the after_save callback.
      # 2. Collects the IDs of saved books.
      # 3. On completion of the Chewy.atomic block, uses the collected IDs to make
      #    a single Elasticsearch index update request.
      around_action { |&block| Chewy.atomic(&block) }
    end

  end
end
