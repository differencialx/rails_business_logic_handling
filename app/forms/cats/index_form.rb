module Cats
  class IndexForm
    include ActiveModel::Model

    ALLOWED_SORT_OPTIONS = %w[
      name
      age
      weight
      breed
    ].freeze

    attr_accessor :breed,
                  :age_from,
                  :age_to,
                  :weight_from,
                  :weight_to,
                  :sort

    validates :breed, presence: true, allow_blank: true
    validates :age_to, :weight_to,
              numericality: { only_integer: true },
              presence: true,
              allow_nil: true
    validates :age_from, :weight_from,
              numericality: { only_integer: true, greater_than_or_equal_to: 1 },
              presence: true,
              allow_nil: true
    validates :sort, presence: true, format: {with: /\w/}, allow_nil: true
    validate :sort_options, :age_from_to, :weight_from_to, :breed_values

    def sort_options
      return if sort.blank?
      return if errors.present?

      sort_param = sort.gsub('-', '')
      unless ALLOWED_SORT_OPTIONS.include?(sort_param)
        errors.add(:sort, "#{sort_param} is not allowed")
      end
    end

    def age_from_to
      return if age_from.blank? && age_to.present?
      return if age_from.present? && age_to.blank?
      return if age_from.blank? && age_to.blank?
      return if age_from < age_to

      errors.add(:age, 'age_to should be greater then age_from')
    end

    def weight_from_to
      return if weight_from.blank? && weight_to.present?
      return if weight_from.present? && weight_to.blank?
      return if weight_from.blank? && weight_to.blank?
      return if weight_from < weight_to

      errors.add(:weight, 'weight_to should be greater then weight_from')
    end

    def breed_values
      return if breed.blank?
      return if breed.all? { |value| value.is_a?(String) }

      errors.add(:breed, 'Breed values should be string')
    end
  end
end
