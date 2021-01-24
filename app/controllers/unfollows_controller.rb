class UnfollowsController < ApplicationController
  def create
    user = User.find(params[:account_id])
    current_user.unfollow!(user)
    redirect_to account_path(id: user.id)
  end
end
