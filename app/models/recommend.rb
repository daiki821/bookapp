# == Schema Information
#
# Table name: recommends
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_recommends_on_user_id  (user_id)
#
class Recommend < ApplicationRecord
  validates :title,   presence: true
  validates :content, presence: true
  validates :content, length: { maximum: 200 }

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

 
end
