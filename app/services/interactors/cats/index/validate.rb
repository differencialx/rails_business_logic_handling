module Interactors
  module Cats
    module Index
      class Validate < BaseInteractor
        def call
          form = ::Cats::IndexForm.new(context.params)

          return if form.valid?

          context.fail!(
            errors: form.errors.full_messages,
            semantic_status: 400
          )
        end
      end
    end
  end
end
