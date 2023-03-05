module DecouplioActions
  module Cats
    class FetchImageUrl
      def self.call(ctx, ms)
        response = Faraday.get('https://aws.random.cat/meow')

        if response.status == 200
          ctx[:image_url] =  JSON(response.body)['file']
          true
        else
          ms.errors = ['Fetch image error']
          ms.semantic = 503
          false
        end

      rescue => error
        ms.errors = ['Oops, something went wrong']
        ms.semantic = 500
        false
      end
    end
  end
end
