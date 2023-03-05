module YasoServices
  module Cats
    class HandleImageFetch
      def self.call(ctx)
        return true if ctx[:image_url].present?

        ctx[:errors] = ['We are experiencing image fetching issues, please try again later']
        ctx[:semantic] = 503
        false
      end
    end
  end
end
