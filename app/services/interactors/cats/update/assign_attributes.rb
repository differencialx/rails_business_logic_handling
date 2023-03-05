module Interactors
  module Cats
    module Update
      class AssignAttributes < BaseInteractor
        def call
          context.model.assign_attributes(context.params.merge(image_url: context.image_url))
        end
      end
    end
  end
end
