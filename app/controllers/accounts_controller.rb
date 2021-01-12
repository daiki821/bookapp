class AccountsController < ApplicationController

  def show
    @account = User.find(params[:id])
    @recommends = @account.recommends.all
    if @account.id == current_user.id
      redirect_to user_path
    end
  end
end