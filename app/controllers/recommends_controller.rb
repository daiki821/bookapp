class RecommendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @search = Recommend.ransack(params[:q])
    @search_recommends = @search.result.page(params[:page]).per(4).order(created_at: :desc)
  end

  def show
    @recommend = Recommend.find(params[:id])
    @comments = @recommend.comments
  end

  def new
    @recommend = current_user.recommends.build
  end

  def create
    @recommend = current_user.recommends.build(recommend_params)
    if @recommend.save
      redirect_to recommends_path, notice: '保存できました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end

  def destroy
    @recommend = current_user.recommends.find(params[:id])
    @recommend.destroy!
    redirect_to recommends_path, notice: '削除しました'
  end

  private

  def recommend_params
    params.require(:recommend).permit(:image, :title, :content)
  end
end
