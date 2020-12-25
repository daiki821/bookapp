class RecommendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @recommends = Recommend.all
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