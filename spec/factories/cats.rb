FactoryBot.define do
  factory :cat do
    sequence(:name) { |number| "#{FFaker::AnimalUS.common_name}##{number}" }
    breed { FFaker::Vehicle::make }
    weight { FFaker.rand(1..15) }
    age { FFaker.rand(1..15) }
    image_url { 'http://stub.stub/stub' }
  end
end
