class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to places_path
    else
      redirect_to new_session_path, notice: "Invalid email or password" # Update here
    end
  end  

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path # Use the correct route helper
  end
end