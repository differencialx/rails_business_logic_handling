module YasoServices
  module Common
    class Persist
      def self.call(ctx, key:)
        return true if ctx[key].save

        ctx[:errors] = ctx[:model].errors.full_messages
        ctx[:semantic] = 422
        false
      end
    end
  end
end
