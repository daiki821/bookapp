class FavoriteController < ApplicationController

  def index
    @path = request.fullpath
    if @path == '/user/favorite'
      @user = current_user
      @favorites = current_user.favorite_recommends
    else
      @user = User.find(params[:account_id])
      @favorites = @user.favorite_recommends
    end
  end
end