# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  completed    :boolean          default(FALSE), not null
#  completed_at :date             not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
class Task < ApplicationRecord
  has_one_attached :image
  belongs_to :user
end
