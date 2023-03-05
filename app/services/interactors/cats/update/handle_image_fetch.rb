module Interactors
  module Cats
    module Update
      class HandleImageFetch < BaseInteractor
        def call
          return if context.image_url.present?

          context.fail!(
            errors: ['We are experiencing image fetching issues, please try again later'],
            semantic_status: 503
          )
        end
      end
    end
  end
end
