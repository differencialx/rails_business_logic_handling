module TrailblazerOperations
  module Macros
    def self.Validate(validator_class = nil, params_key: :params)
      step = -> (ctx, **) {
        form = validator_class.new(OpenStruct.new)
        validation_result = form.validate(ctx[:params])
        unless validation_result
          ctx['contract.validate.errors'] = form.errors.full_messages
          ctx['contract.semantic_status'] = 400
        end

        validation_result ? Trailblazer::Activity::Right : Trailblazer::Activity::FastTrack::FailFast
      }

      task = ::Trailblazer::Activity::Circuit::TaskAdapter.for_step(step)

      {
        task: task,
        id: 'contract.validate'
      }
    end

    def self.InitScope(model:, scope:, to_key:)
      step = -> (ctx, **) {
        ctx[to_key] = model.public_send(scope)

        Trailblazer::Activity::Right
      }

      task = ::Trailblazer::Activity::Circuit::TaskAdapter.for_step(step)

      {
        task: task,
        id: 'scope.init'
      }
    end

    def self.Query(query_class = nil, scope_key: :model, query_params_key:)
      step = -> (ctx, **) {
        ctx[:model] = query_class.call(
          scope: ctx[scope_key],
          **ctx[query_params_key]
        )

        Trailblazer::Activity::Right
      }

      task = ::Trailblazer::Activity::Circuit::TaskAdapter.for_step(step)

      {
        task: task,
        id: 'query.filter'
      }
    end

    def self.Paginate(scope_key: :model, pagy_meta_key: :pagy_meta, pagy_params_key: :pagy_params)
      step = -> (ctx, **) {
        pagy_meta, records = Pagination.call(
          scope: ctx[scope_key],
          options: ctx[pagy_params_key]
        )
        ctx[scope_key] = records
        ctx[pagy_meta_key] = pagy_meta

        Trailblazer::Activity::Right
      }

      task = ::Trailblazer::Activity::Circuit::TaskAdapter.for_step(step)

      {
        task: task,
        id: 'paginate'
      }
    end

    def self.Decorate(key_to_decorate: :model)
      step = -> (ctx, **) {
        ctx[key_to_decorate] = ctx[key_to_decorate].decorate

        Trailblazer::Activity::Right
      }

      task = ::Trailblazer::Activity::Circuit::TaskAdapter.for_step(step)

      {
        task: task,
        id: 'decorate'
      }
    end
  end
end
