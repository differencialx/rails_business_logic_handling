module DecouplioActions
  module Common
    class Validate
      def self.call(ctx, ms, validator:, params_key: :params)
        form = validator.new(ctx[params_key])

        return true if form.valid?

        ms.errors = form.errors.full_messages
        ms.semantic = 400

        false
      end
    end
  end
end
