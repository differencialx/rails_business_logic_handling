module Poro
  module Cats
    class Update
      def self.call(...)
        new(...).call
      end

      attr_reader :errors, :status, :cat

      def initialize(params:, id:)
        @id = id
        @params = params
        @errors = []
        @status = nil
      end

      def call
        @cat = fetch_cat

        unless @cat
          @errors << 'Record not found'
          @status = 404
          return self
        end

        @image_url = fetch_image_url

        return self if failure?

        if @image_url.blank?
          @errors << 'We are experiencing image fetching issues, please try again later'
          @status = 503
          return self
        end

        assign_attributes

        persist

        return self if failure?

        decorate

        self
      end

      def success?
        @errors.empty?
      end

      def failure?
        !success?
      end

      private

      def fetch_cat
        Cat.find_by(id: @id)
      end

      def fetch_image_url
        response = Faraday.get('https://aws.random.cat/meow')

        if response.status == 200
          return JSON(response.body)['file']
        else
          @errors << 'Fetch image error'
          @status = 503
        end

      rescue => error
        @errors << 'Oops, something went wrong'
        @status = 500
      end

      def assign_attributes
        @cat.assign_attributes(@params.merge(image_url: @image_url))
      end

      def persist
        return if @cat.save

        @errors = @cat.errors.full_messages
        @status = 422
      end

      def decorate
        @cat = @cat.decorate
      end
    end
  end
end
