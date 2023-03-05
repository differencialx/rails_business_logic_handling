module DecouplioActions
  module Common
    class FetchRecord
      def self.call(ctx, ms, model:, param:, key: :model)
        ctx[key] = model.find_by(id: ctx[param])

        if ctx[key]
          Decouplio::Action::PASS
        else
          ms.errors = ['Record not found']
          ms.semantic = 404
          Decouplio::Action::FAIL
        end
      end
    end
  end
end
