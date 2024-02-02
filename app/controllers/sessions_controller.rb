class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    ## rails 7.1 User.authenticate_by(email: params[:email], password: params[:password])

    if user && user.authenticate(params[:password])
      login(user)
      flash[:notice] = "Successfully signed in"
      redirect_to root_path
    else
      flash[:alert] = "Incorrect email/password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout(current_user)
    redirect_to root_path, notice: "Successfully logged out"
  end
end