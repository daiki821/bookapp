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
class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :content, :username, :avatar_url


  def username
    object.user.username
  end

  def avatar_url
    if object.user.avatar.attached?
      url_for(object.user.avatar)
    else
      '/assets/default_avatar.png'
    end

  end

end
