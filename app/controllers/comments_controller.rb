class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    recommend = Recommend.find(params[:recommend_id])
    @comments = recommend.comments.all

    render json: @comments
  end

  def new
    @recommend = Recommend.find(params[:recommend_id])
    @comment = @recommend.comments.build
  end

  def create
    @recommend = Recommend.find(params[:recommend_id])
    @comment = @recommend.comments.build(comment_params.merge(user_id: current_user.id))
    @comment.save!
    

    render json: @comment
  end

  def destroy
    recommend = Recommend.find(params[:recommend_id])
    comment = recommend.comments.find(params[:id])
    comment.destroy!
   
    render json: {status: 'ok'}
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
