module YasoServices
  module Cats
    class Update < Yaso::Service
      step YasoServices::Common::FetchRecord,
           model: Cat,
           param: :id,
           fast: :failure
      step YasoServices::Cats::FetchImageUrl,
           fast: :failure
      step YasoServices::Cats::HandleImageFetch,
           fast: :failure
      step YasoServices::Common::AssignAttributes
      step YasoServices::Common::Persist,
           key: :model,
           fast: :failure
      step YasoServices::Common::Decorate,
           key: :model
    end
  end
end
