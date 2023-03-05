module DecouplioActions
  module Cats
    class Update < DecouplioActions::BaseAction
      logic do
        step DecouplioActions::Common::FetchRecord,
             model: Cat,
             param: :id,
             finish_him: :on_failure
        step DecouplioActions::Cats::FetchImageUrl,
             finish_him: :on_failure
        step DecouplioActions::Cats::HandleImageFetch,
             finish_him: :on_failure
        step DecouplioActions::Common::AssignAttributes
        step DecouplioActions::Common::Persist,
             key: :model,
             finish_him: :on_failure
        step DecouplioActions::Common::Decorate,
             key: :model
      end
    end
  end
end
