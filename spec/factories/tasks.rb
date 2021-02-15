# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  completed    :boolean          default(FALSE), not null
#  completed_at :date             not null
#  end_date     :date
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(number: 8) }
    completed_at { '2022-03-12' }
    completed { 'false' }
  end
end
