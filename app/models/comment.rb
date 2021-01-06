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
class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :recommend
end
