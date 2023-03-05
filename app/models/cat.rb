class Cat < ApplicationRecord
  URI_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix

  validates :name, :breed, :image_url, presence: true
  validates :image_url, format: { with: URI_REGEXP, message: 'Invalid url format' }
  validates :age, :weight,
            numericality: { only_integer: true, greater_than_or_equal_to: 1 },
            presence: true
end
