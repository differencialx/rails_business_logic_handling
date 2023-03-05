module YasoServices
  module Common
    class Validate
      def self.call(ctx, validator:, params_key: :params)
        form = validator.new(ctx[params_key])

        return true if form.valid?

        ctx[:errors] = form.errors.full_messages
        ctx[:semantic] = 400

        false
      end
    end
  end
end
