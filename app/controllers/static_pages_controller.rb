class StaticPagesController < ApplicationController
  before_action :redirect_user
  def home
  end

  private
  def redirect_user
    redirect_to todo_tasks_path if user_signed_in?
  end
end
