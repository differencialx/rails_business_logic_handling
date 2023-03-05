module Interactors
  module Cats
    module Index
      class Paginate < BaseInteractor
        def call
          pagy_meta, records = Pagination.call(
            scope: context.scope,
            options: context.pagy_params
          )

          context.pagy_meta = pagy_meta
          context.model = records
        end
      end
    end
  end
end
