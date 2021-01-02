# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  introduction           :text
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence:   true
  validates :username, uniqueness: true

  validates :introduction,  length: { maximum: 100 }

  has_one_attached :avatar

  has_many :tasks, dependent: :destroy
  has_many :outputs, dependent: :destroy
  has_many :recommends, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy


  def avatar?
    if avatar&.attached?
      avatar
    else
      '/assets/default_avatar.png'
    end
  end

  def has_recommend?(recommend)
    recommends.exists?(id: recommend.id)
  end

  def has_liked?(recommend)
    likes.exists?(recommend_id: recommend.id)
  end
end
