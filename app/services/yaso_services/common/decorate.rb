module YasoServices
  module Common
    class Decorate
      def self.call(ctx, key:)
        ctx[key] = ctx[key].decorate
      end
    end
  end
end
