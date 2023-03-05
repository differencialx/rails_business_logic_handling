module TrailblazerOperations
  module Cats
    class Index < Trailblazer::Operation
      step :validate, fast_track: true
      step :filter
      step :paginate
      step :decorate

      def validate(ctx, **)
        form = ::Cats::Reform::Index.new(OpenStruct.new)
        validation_result = form.validate(ctx[:params])
        unless validation_result
          ctx['contract.validate.errors'] = form.errors.full_messages
          ctx['contract.semantic_status'] = 400
        end
        validation_result ? Trailblazer::Activity::Right : Trailblazer::Activity::FastTrack::FailFast
      end

      def filter(ctx, **)
        ctx[:model] = ::Cats::IndexQuery.call(
          scope: Cat.all,
          **ctx[:params]
        )
      end

      def paginate(ctx, **)
        pagy_meta, records = Pagination.call(
          scope: ctx[:model],
          options: ctx[:pagy_params]
        )
        ctx[:model] = records
        ctx[:pagy_meta] = pagy_meta
      end

      def decorate(ctx, **)
        ctx[:model] = ctx[:model].decorate
      end
    end
  end
end
