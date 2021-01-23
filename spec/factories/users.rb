FactoryBot.define do
  factory :user do
    username { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    password { 'password'}
  end
end