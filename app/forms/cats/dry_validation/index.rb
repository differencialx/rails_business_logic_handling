module Cats
  module DryValidation
    class Index < ::Dry::Validation::Contract
      schema do
        optional(:breed).maybe(:array).each(:str?)
        optional(:age_from).filled(:int?, gt?: 0)
        optional(:age_to).filled(:int?, gt?: 0)
        optional(:weight_from).filled(:int?, gt?: 0)
        optional(:weight_to).filled(:int?, gt?: 0)
        optional(:sort).filled(:str?)
      end

      rule(:weight_from, :weight_to) do
        if values[:weight_to].present? && values[:weight_from].present?
          key.failure('Weight weight_to should be greater than weight_from') if values[:weight_from] > values[:weight_to]
        end
      end

      rule(:age_from, :age_to) do
        if values[:age_to].present? && values[:age_from].present?
          key.failure('Age age_to should be greater than age_from') if values[:age_from] > values[:age_to]
        end
      end

      rule(:sort) do
        if value.present?
          sort_param = value.gsub('-', '')
          unless Cats::IndexForm::ALLOWED_SORT_OPTIONS.include?(sort_param)
            key.failure("#{sort_param} is not allowed")
          end
        end
      end
    end
  end
end
