class UsersController < ApplicationController
  before_action :require_user, only: [:follow, :unfollow]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have registered!"
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def show
    @user = User.find_by username: params[:username]
  end

  def follow
    user = User.find(params[:id])
    if user
      current_user.following_users << User.find(params[:id])
      flash[:notice] = "You are now following #{user.username}."
      redirect_to user_path(user.username)
    else
      wrong_path
    end
  end

  def unfollow
    user = User.find(params[:id])
    rel = Relationship.where(follower: current_user, leader: user).first
    if user && rel
      rel.destroy
      flash[:notice] = "You are no longer following #{user.username}."
      redirect_to user_path(user.username)
    else
      wrong_path
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end

