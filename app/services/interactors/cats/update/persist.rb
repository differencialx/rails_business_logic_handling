module Interactors
  module Cats
    module Update
      class Persist < BaseInteractor
        def call
          return if context.model.save

          context.fail!(
            errors: context.model.errors.full_messages,
            semantic_status: 422
          )
        end
      end
    end
  end
end
