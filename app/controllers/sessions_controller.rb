class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      #remember checkbox clicked or not
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # remember user
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # log_out
    log_out if logged_in?
    redirect_to root_url
  end
end
