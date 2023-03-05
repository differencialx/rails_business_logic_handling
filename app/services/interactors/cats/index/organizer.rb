module Interactors
  module Cats
    module Index
      class Organizer < BaseOrganizer
        organize Interactors::Cats::Index::Validate,
                 Interactors::Cats::Index::Filter,
                 Interactors::Cats::Index::Paginate,
                 Interactors::Cats::Index::Decorate
      end
    end
  end
end
