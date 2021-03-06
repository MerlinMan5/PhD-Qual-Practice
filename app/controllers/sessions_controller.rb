class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    # @user = User.where(email: params[:session][:email]).first
    
    if @user.nil?
      session[:flash] = ("Please consider signing up: " + params[:session][:email] + " : " + params[:session][:password])
      session[:user_id] = nil
      redirect_to register_url
      return
    end

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:flash] = ("Welcome: " + @user.name)
      redirect_to root_url
      return
    else
      session[:flash] = ("Invalid Username or Password")
      redirect_to login_url
      return
    end
  end

  def destroy
    session[:user_id] = nil
    session[:flash] = ("Succesfully logged out")
    redirect_to login_url
    return
  end
end
