module YasoServices
  module Cats
    class FetchImageUrl
      def self.call(ctx)
        response = Faraday.get('https://aws.random.cat/meow')

        if response.status == 200
          ctx[:image_url] =  JSON(response.body)['file']
          true
        else
          ctx[:errors] = ['Fetch image error']
          ctx[:semantic] = 503
          false
        end

      rescue => error
        ctx[:errors] = ['Oops, something went wrong']
        ctx[:semantic] = 500
        false
      end
    end
  end
end
