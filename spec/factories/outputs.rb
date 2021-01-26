FactoryBot.define do
  factory :output do
    content { Faker::Lorem.characters(number: 20) }
  end
end
