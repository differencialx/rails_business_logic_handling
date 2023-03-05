module DecouplioActions
  module Cats
    class HandleImageFetch
      def self.call(ctx, ms)
        return Decouplio::Action::PASS if ctx.image_url.present?

        ms.errors = ['We are experiencing image fetching issues, please try again later']
        ms.semantic = 503
        Decouplio::Action::FAIL
      end
    end
  end
end
