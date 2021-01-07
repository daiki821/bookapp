class FollowsController < ApplicationController

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
    redirect_to account_path(id: user.id)
  end
end