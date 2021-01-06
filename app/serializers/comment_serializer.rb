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
