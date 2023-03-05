module Poro
  module Cats
    class Index
      def self.call(...)
        new(...).call
      end

      attr_reader :errors, :status, :pagy_meta, :records

      def initialize(params:, pagination_params:)
        @params = params
        @pagination_params = pagination_params
        @errors = []
        @status = nil
      end

      def call
        validate_params

        return self if errors_present?

        filter_collection
        paginate
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

      def decorate
        @records = @records.decorate
      end

      def paginate
        @pagy_meta, @records = Pagination.call(
          scope: @scope,
          options: @pagination_params
        )
      end

      def filter_collection
        @scope = ::Cats::IndexQuery.call(
          scope: Cat.all,
          **query_params
        )
      end

      def validate_params
        form = ::Cats::IndexForm.new(@params)
        unless form.valid?
          @errors = form.errors.full_messages
          @status = 400
        end
      end

      def query_params
        @params.slice(:breed, :age_from, :age_to, :weight_from, :weight_to, :sort)
      end

      def errors_present?
        @errors.present?
      end
    end
  end
end
