module BusinessLogic
  module Fat
    class CatsController < ApplicationController
      include Pagy::Backend

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def index
        # Form object
        form = Cats::IndexForm.new(index_params)
        unless form.valid?
          return render json: form.errors.full_messages, status: 400
        end

        # Reform
        # form = Cats::Reform::Index.new(OpenStruct.new)
        # unless form.validate(index_params)
        #   return render json: form.errors.full_messages, status: 422
        # end

        # Dry validation
        # form = Cats::DryValidation::Index.new
        # validation_result = form.call(index_params.to_h)
        # if validation_result.failure?
        #   return render json: validation_result.errors(full: true).messages.map(&:to_s), status: 422
        # end

        scope = Cat.all
        if index_params[:breed].present?
          scope = scope.where(breed: index_params[:breed])
        end
        if index_params[:age_from].present? && index_params[:age_to].present?
          scope = scope.where(age: [index_params[:age_from]..index_params[:age_to]])
        elsif index_params[:age_from].present? && index_params[:age_to].blank?
          scope = scope.where('age >= ?', index_params[:age_from])
        elsif index_params[:age_from].blank? && index_params[:age_to].present?
          scope = scope.where('age <= ?', index_params[:age_to])
        end
        if index_params[:weight_from].present? && index_params[:weight_to].present?
          scope = scope.where(weight: [index_params[:weight_from]..index_params[:weight_to]])
        elsif index_params[:weight_from].present? && index_params[:weight_to].blank?
          scope = scope.where('weight >= ?', index_params[:weight_from])
        elsif index_params[:weight_from].blank? && index_params[:weight_to].present?
          scope = scope.where('weight <= ?', index_params[:weight_to])
        end
        if index_params[:sort].present?
          if index_params[:sort].first == '-'
            scope = scope.order(index_params[:sort].gsub('-', '') => :desc)
          else
            scope = scope.order(index_params[:sort] => :asc)
          end
        else
          scope = scope.order(created_at: :asc)
        end
        pagy, records = pagy(scope, items: params[:items])
        decorated_cats = records.decorate
        render json: { data: Cats::CatSerializer.new(decorated_cats).to_h, pagy: pagy_metadata(pagy) }
      end

      def update
        cat = Cat.find_by(id: params[:id])

        unless cat
          return render json: ['Record not found'], status: 404
        end

        image_url = ''
        response = Faraday.get('https://aws.random.cat/meow')
        if response.status == 200
          image_url = JSON(response.body)['file']
        else
          return render json: ['Fetch image error'], status: 503
        end

        if image_url.blank?
          return render json: ['We are experiencing image fetching issues, please try again later'], status: 503
        end

        cat.assign_attributes(update_params.to_h.merge(image_url: image_url))

        if cat.save
          decorated_cat = cat.decorate
          render json: { data: Cats::CatSerializer.new(decorated_cat).to_h }
        else
          render json: cat.errors.full_messages, status: 422
        end

      rescue => error
        render json: ['Oops, something went wrong'], status: 500
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

      def update_params
        params.permit(:name, :age, :weight, :breed)
      end
    end
  end
end
