module Interactors
  module Cats
    module Update
      class FetchCat < BaseInteractor
        def call
          context.model = Cat.find_by(id: context.id)

          return if context.model

          context.fail!(errors: ['Record not found'], semantic_status: 404)
        end
      end
    end
  end
end
