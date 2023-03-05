module DecouplioActions
  module Common
    class Decorate
      def self.call(ctx, ms, key:)
        ctx[key] = ctx[key].decorate
      end
    end
  end
end
