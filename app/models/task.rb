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
  validates :title,        presence: true
  validates :completed_at, presence: true

  has_one_attached :image 

  has_one :output, dependent: :destroy

  belongs_to :user


  def has_image?
    if image&.attached?
      image
    else
      '/assets/noimage.png'
    end
  end

  def prepare_output(user)
    output || build_output(user_id: user.id) 
  end


end
