module YasoServices
  module Common
    class Paginate
      def self.call(ctx, key:)
        pagy_meta, records = Pagination.call(
          scope: ctx[key],
          options: ctx[:pagy_params]
        )

        ctx[:pagy_meta] = pagy_meta
        ctx[key] = records
      end
    end
  end
end
