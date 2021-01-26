FactoryBot.define do
  factory :recommend do
    title { Faker::Lorem.characters(number: 18) }
    content { Faker::Lorem.characters(number: 100) }
  end
end
