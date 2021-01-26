FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(number: 8) }
    completed_at { '2022-03-12' }
    completed { 'false' }
  end
end
