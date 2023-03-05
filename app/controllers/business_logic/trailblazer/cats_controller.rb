module BusinessLogic
  module Trailblazer
    class CatsController < ApplicationController
      ###
      # usually this code is placed at Base controller class like ApplicationController, Api::V1::Base
      include SimpleEndpoint::Controller

      cases do
        match(:success) { |result| result.success? }
        match(:bad_request) { |result| result.failure? && result['contract.semantic_status'] == 400 }
        match(:not_found) { |result| result.failure? && result['contract.semantic_status'] == 404 }
        match(:unprocessable_entity) { |result| result.failure? && result['contract.semantic_status'] == 422 }
        match(:server_error) { |result| result.failure? && result['contract.semantic_status'] == 500 }
        match(:service_unavailable) { |result| result.failure? && result['contract.semantic_status'] == 503 }
      end

      handler do
        on(:success) do |result, **opts|
          pagy_meta = { pagy: result[:pagy_meta] }
          render json: {
                   data: opts[:serializer].new(result[:model]).to_h,
                   **pagy_meta
                 }.compact,
                 status: 200
        end
        on(:bad_request) do |result, **|
          render json: result['contract.validate.errors'],
                 status: 400
        end
        on(:not_found) do |result, **|
          render json: result['contract.validate.errors'],
                 status: 404
        end
        on(:unprocessable_entity) do |result, **|
          render json: result['contract.validate.errors'],
                 status: 422
        end
        on(:server_error) do |result, **|
          render json: result['contract.validate.errors'],
                 status: 500
        end
        on(:service_unavailable) do |result, **|
          render json: result['contract.validate.errors'],
                 status: 503
        end
      end

      ###

      def index
        # endpoint operation: TrailblazerOperations::Cats::IndexWithMacro,
        endpoint operation: TrailblazerOperations::Cats::Index,
                 renderer_options: { serializer: Cats::CatSerializer },
                 options: {
                   params: index_params.to_h.symbolize_keys,
                   pagy_params: pagination_params.to_h.symbolize_keys
                 }
      end

      def update
        endpoint operation: TrailblazerOperations::Cats::Update,
                 renderer_options: { serializer: Cats::CatSerializer },
                 options: {
                   params: update_params.to_h.symbolize_keys,
                   id: params[:id]
                 }
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
