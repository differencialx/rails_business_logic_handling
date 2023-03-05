module TrailblazerOperations
  module Cats
    class Update < Trailblazer::Operation
      step :fetch_cat
      fail :handle_fetch_cat, fast_track: true
      step :fetch_image_url, fast_track: true
      step :image_present?
      fail :handle_image_presence, fast_track: true
      pass :assign_attributes
      step :persist
      fail :handle_persist, fast_track: true
      step :decorate, id: :decor

      def fetch_cat(ctx, **)
        ctx[:model] = Cat.find_by(id: ctx[:id])
      end

      def handle_fetch_cat(ctx, **)
        ctx['contract.validate.errors'] = ['Record not found']
        ctx['contract.semantic_status'] = 404
        Railway.fail_fast!
      end

      def fetch_image_url(ctx, **)
        response = Faraday.get('https://aws.random.cat/meow')

        if response.status == 200
          ctx[:image_url] = JSON(response.body)['file']
          Railway.pass!
        else
          ctx['contract.validate.errors'] = ['Fetch image error']
          ctx['contract.semantic_status'] = 503
          Railway.fail_fast!
        end

      rescue Timeout::Error => error
        ctx['contract.validate.errors'] = ['Oops, something went wrong']
        ctx['contract.semantic_status'] = 500
        Railway.fail_fast!
      end

      def image_present?(ctx, **)
        ctx[:image_url].present?
      end

      def handle_image_presence(ctx, **)
        ctx['contract.validate.errors'] = ['We are experiencing image fetching issues, please try again later']
        ctx['contract.semantic_status'] = 503
        Railway.fail_fast!
      end

      def assign_attributes(ctx, **)
        ctx[:model].assign_attributes(ctx[:params].merge(image_url: ctx[:image_url]))
      end

      def persist(ctx, **)
        ctx[:model].save
      end

      def handle_persist(ctx, **)
        ctx['contract.validate.errors'] = ctx[:model].errors.full_messages
        ctx['contract.semantic_status'] = 422
        Railway.fail_fast!
      end

      def decorate(ctx, **)
        ctx[:model] = ctx[:model].decorate
      end
    end
  end
end
