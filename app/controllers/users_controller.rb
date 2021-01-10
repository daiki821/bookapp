class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @recommends = @user.recommends.all
  end
end