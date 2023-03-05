class CatDecorator < Draper::Decorator
  TO_LBS = 2.2046226218487757

  delegate :id, :breed, :image_url

  def id
    object.id
  end

  def name
    "🐈 #{object.name} 🐈"
  end

  def weight_kg
    object.weight
  end

  def weight_lbs
    (object.weight * TO_LBS).to_i
  end

  def age_months
    object.age * 12
  end

  def age_years
    object.age
  end
end
