class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    recommend = Recommend.find(params[:recommend_id]) 
    like = current_user.likes.build(recommend_id: recommend.id)
    like.save!
    redirect_to recommends_path
  end

  def destroy
    recommend = Recommend.find(params[:recommend_id])
    like = current_user.likes.find_by(recommend_id: recommend.id)
    like.destroy!
    redirect_to recommends_path
  end


end