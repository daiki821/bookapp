# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recommend_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_comments_on_recommend_id  (recommend_id)
#  index_comments_on_user_id       (user_id)
#
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 20) }
  end
end
