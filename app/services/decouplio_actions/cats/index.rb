module DecouplioActions
  module Cats
    class Index < DecouplioActions::BaseAction
      logic do
        step DecouplioActions::Common::Validate,
             validator: ::Cats::IndexForm,
             on_failure: :finish_him
        step DecouplioActions::Common::Query,
             query: ::Cats::IndexQuery,
             to: :model,
             scope: ->() { Cat.all }
        step DecouplioActions::Common::Paginate,
             key: :model
        step DecouplioActions::Common::Decorate,
             key: :model
      end
    end
  end
end
