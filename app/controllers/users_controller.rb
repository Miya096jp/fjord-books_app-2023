class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(created_at: :asc).page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
  end
end
