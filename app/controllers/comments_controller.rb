class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    recommend = Recommend.find(params[:recommend_id])
    @comments = recommend.comments.all
    user_id = current_user.id

    render json: @comments, meta: user_id
  end

  def create
    @recommend = Recommend.find(params[:recommend_id])
    @comment = @recommend.comments.build(comment_params.merge(user_id: current_user.id))
    @comment.save!
    comment_count = @recommend.comments.count
    user_id = current_user.id

    render json: @comment, meta: {count: comment_count, id: user_id }
  end

  def destroy
    recommend = Recommend.find(params[:recommend_id])
    comment = recommend.comments.find(params[:id])
    comment.destroy!
    comment_count = recommend.comments.count

    render json: {status: 'ok', commentCount: comment_count }
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
