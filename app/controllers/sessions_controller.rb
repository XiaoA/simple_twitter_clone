class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you're logged in!"
      redirect_to user_path(user)
    else
      flash.now[:error] = "There is something wrong with your username or password."
      render :new
    end
  end
end
