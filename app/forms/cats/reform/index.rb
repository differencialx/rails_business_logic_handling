module Cats
  module Reform
    class Index < ::Reform::Form
      feature ::Reform::Form::Dry

      property :breed
      property :age_from
      property :age_to
      property :weight_from
      property :weight_to
      property :sort

      validation do
        params do
          optional(:breed).maybe(:array) { each { str? } } # you will spend some time for this
          optional(:age_from).maybe(:int?, gt?: 0) # maybe because Reform initializes keys in Openstruct
          optional(:age_to).maybe(:int?, gt?: 0) # maybe because Reform initializes keys in Openstruct
          optional(:weight_from).maybe(:int?, gt?: 0) # maybe because Reform initializes keys in Openstruct
          optional(:weight_to).maybe(:int?, gt?: 0) # maybe because Reform initializes keys in Openstruct
          optional(:sort).maybe(:string)
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
end
