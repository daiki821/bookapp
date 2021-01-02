class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
  
  end

  def new
    @recommend = Recommend.find(params[:recommend_id])
    @comment = @recommend.comments.build
  end

  def create
    @recommend = Recommend.find(params[:recommend_id])
    @comment = @recommend.comments.build(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to recommend_path(id: @recommend), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def destroy
    recommend = Recommend.find(params[:recommend_id])
    comment = recommend.comments.find(params[:id])
    comment.destroy!
    redirect_to recommend_path(id: recommend.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end