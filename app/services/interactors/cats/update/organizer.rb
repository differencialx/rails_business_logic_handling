module Interactors
  module Cats
    module Update
      class Organizer < BaseOrganizer
        organize Interactors::Cats::Update::FetchCat,
                 Interactors::Cats::Update::FetchImageUrl,
                 Interactors::Cats::Update::HandleImageFetch,
                 Interactors::Cats::Update::AssignAttributes,
                 Interactors::Cats::Update::Persist,
                 Interactors::Cats::Update::Decorate
      end
    end
  end
end
