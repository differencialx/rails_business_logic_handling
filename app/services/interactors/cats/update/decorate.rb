module Interactors
  module Cats
    module Update
      class Decorate < BaseInteractor
        def call
          context.model = context.model.decorate
        end
      end
    end
  end
end
