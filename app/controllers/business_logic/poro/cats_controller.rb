module BusinessLogic
  module Poro
    class CatsController < ApplicationController
      # Default style
      def index
        outcome = ::Poro::Cats::Index.call(
          params: index_params.to_h.symbolize_keys,
          pagination_params: pagination_params.to_h.symbolize_keys
        )

        if outcome.success?
          render json: { data: Cats::CatSerializer.new(outcome.records).to_h, pagy: outcome.pagy_meta }
        else
          render json: outcome.errors, status: outcome.status
        end
      end

      def update
        outcome = ::Poro::Cats::Update.call(
          params: update_params.to_h,
          id: params[:id]
        )

        if outcome.success?
          render json: { data: Cats::CatSerializer.new(outcome.cat).to_h }
        else
          render json: outcome.errors, status: outcome.status
        end
      end

      def filters
        render json: {
          filters: {
            breed: Cat.all.group(:breed).count.keys,
            ageFrom: Cat.all.minimum(:age),
            ageTo: Cat.all.maximum(:age),
            weightFrom: Cat.all.minimum(:weight),
            weightTo: Cat.all.maximum(:weight),
          }
        }
      end

      # Simple endpoint style

      # include SimpleEndpoint::Controller

      # cases do
      #   match(:success) { |result| result.success? }
      #   match(:bad_request) { |result| result.failure? && result.status == 400 }
      # end

      # handler do
      #   on(:success) do |result, **opts|
      #     render json: {
      #       data: opts[:serializer].new(result.records).to_h, pagy: result.pagy_meta },
      #       status: 200
      #   end
      #   on(:bad_request) do |result, **|
      #     render json: result.errors,
      #             status: 400
      #   end
      # end

      # def index
      #   endpoint operation: ::Poro::Cats::Index,
      #             renderer_options: { serializer: Cats::CatSerializer },
      #             options: {
      #               params: index_params.to_h.symbolize_keys,
      #               pagination_params: pagination_params.to_h.symbolize_keys
      #             }
      # end

      private

      def index_params
        params.permit(:age_from, :age_to, :weight_from, :weight_to, :sort, breed: [])
      end

      def pagination_params
        params.permit(:page, :items)
      end

      def update_params
        params.permit(:name, :age, :weight, :breed)
      end
    end
  end
end
