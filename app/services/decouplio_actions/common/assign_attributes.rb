module DecouplioActions
  module Common
    class AssignAttributes
      def self.call(ctx, ms)
        ctx.model.assign_attributes(ctx.params.merge(image_url: ctx.image_url))
        Decouplio::Action::PASS
      end
    end
  end
end
