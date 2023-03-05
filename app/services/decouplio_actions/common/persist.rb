module DecouplioActions
  module Common
    class Persist
      def self.call(ctx, ms, key:)
        return Decouplio::Action::PASS if ctx[key].save

        ms.errors = ctx.model.errors.full_messages
        ms.semantic = 422
        Decouplio::Action::FAIL
      end
    end
  end
end
