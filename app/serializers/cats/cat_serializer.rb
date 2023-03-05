module Cats
  class CatSerializer < BaseSerializer
    root_key :cat, :cats

    attributes :id,
               :name,
               :breed,
               :weight_kg,
               :weight_lbs,
               :age_years,
               :age_months,
               :image_url
  end
end
