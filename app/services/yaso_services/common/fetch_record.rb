module YasoServices
  module Common
    class FetchRecord
      def self.call(ctx, model:, param:, key: :model)
        ctx[key] = model.find_by(id: ctx[param])

        if ctx[key]
          true
        else
          ctx[:errors] = ['Record not found']
          ctx[:semantic] = 404
          false
        end
      end
    end
  end
end
