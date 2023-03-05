module Interactors
  module Cats
    module Index
      class Filter < BaseInteractor
        def call
          context.scope = ::Cats::IndexQuery.call(
            scope: Cat.all,
            **context.params
          )
        end
      end
    end
  end
end
