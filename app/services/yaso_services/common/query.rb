module YasoServices
  module Common
    class Query
      def self.call(ctx, query:, params_key: :params, scope:, to:)
        ctx[to] = query.call(scope: scope.call, **ctx[params_key])
      end
    end
  end
end
