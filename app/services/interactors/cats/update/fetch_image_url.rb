module Interactors
  module Cats
    module Update
      class FetchImageUrl < BaseInteractor
        def call
          response = Faraday.get('https://aws.random.cat/meow')

          if response.status == 200
            context.image_url =  JSON(response.body)['file']
          else
            context.fail!(errors: ['Fetch image error'], semantic_status: 503)
          end

        # Interactor's context.fail! raises an exception so you need to specify exact error class
        # otherwise you will rescue interactor error
        rescue Timeout::Error => error
          context.fail!(errors: ['Oops, something went wrong'], semantic_status: 500)
        end
      end
    end
  end
end
