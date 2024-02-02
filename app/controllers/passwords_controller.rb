class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(password_params)
      flash[:notice] = "Your password has been sucessfull reset"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password, 
      :password_confirmation
      # In rails 7.1 :password_challenge
    ) # rails 7.1 .with_defaults(password_challenge: "")
    # Makes the user enter in their old password when creating a new one
  end
end