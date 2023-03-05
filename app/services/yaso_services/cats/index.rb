module YasoServices
  module Cats
    class Index < Yaso::Service
      step YasoServices::Common::Validate,
           validator: ::Cats::IndexForm,
           fast: :failure
      step YasoServices::Common::Query,
           query: ::Cats::IndexQuery,
           to: :model,
           scope: ->() { Cat.all }
      step YasoServices::Common::Paginate,
           key: :model
      step YasoServices::Common::Decorate,
           key: :model
    end
  end
end
