class LikesController < ApplicationController
  before_action :authenticate_user!

  def show
    recommend = Recommend.find(params[:recommend_id])
    like_status = current_user.has_liked?(recommend)
    render json: { hasLiked: like_status }
  end

  def create
    recommend = Recommend.find(params[:recommend_id])
    like = recommend.likes.create!(user_id: current_user.id)
    like_count = recommend.likes.count

    render json: { status: 'ok', likeCount: like_count }
  end

  def destroy
    recommend = Recommend.find(params[:recommend_id])
    like = recommend.likes.find_by(user_id: current_user.id)
    like.destroy!
    like_count = recommend.likes.count

    render json: { status: 'ok', likeCount: like_count }
  end

end
