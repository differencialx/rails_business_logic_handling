module Cats
  class IndexQuery
    def self.call(...)
      new(...).call
    end

    def initialize(scope:, breed: nil, age_from: nil, age_to: nil, weight_from: nil, weight_to: nil, sort: nil)
      @breed = breed
      @age_from = age_from
      @age_to = age_to
      @weight_from = weight_from
      @weight_to = weight_to
      @sort = sort
      @scope = scope
    end

    def call
      @scope = filter_by_breed
      @scope = filter_by_age
      @scope = filter_by_weight
      @scope = sort

      @scope
    end

    private

    def filter_by_breed
      return @scope if @breed.blank?

      @scope.where(breed: @breed)
    end

    def filter_by_age
      if @age_from.present? && @age_to.present?
        @scope.where(age: [@age_from..@age_to])
      elsif @age_from.present? && @age_to.blank?
        @scope.where('age >= ?', @age_from)
      elsif @age_from.blank? && @age_to.present?
        @scope.where('age <= ?', @age_to)
      else
        @scope
      end
    end

    def filter_by_weight
      if @weight_from.present? && @weight_to.present?
        @scope.where(weight: [@weight_from..@weight_to])
      elsif @weight_from.present? && @weight_to.blank?
        @scope.where('weight >= ?', @weight_from)
      elsif @weight_from.blank? && @weight_to.present?
        @scope.where('weight <= ?', @weight_to)
      else
        @scope
      end
    end

    def sort
      if @sort.present?
        if @sort.first == '-'
          @scope.order(@sort.gsub('-', '') => :desc)
        else
          @scope.order(@sort => :asc)
        end
      else
        @scope.order(created_at: :asc)
      end
    end
  end
end
