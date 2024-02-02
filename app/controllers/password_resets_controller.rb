class PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: [:edit, :update]

  def new
  end

  def create
    if (user = User.find_by(email: params[:email]))
      PasswordMailer.with(
        user: user,
        # if rails 7.1 token: user.generate_token_for(:password_reset)
        token: create_token({ user_id: user.id })
      ).password_reset.deliver_later
    end

    flash[:notice] = "If the email is on record we will send an email"
    redirect_to root_path
  end

  def edit
  end

  def update
    if @user.update(password_params)
      flash[:notice] = "Your password has been reset successfully, please log in."
      redirect_to new_sessions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private 

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user_by_token
    # if rails 7.1 @user = User.find_by_token_for(:password_reset, params[:token])
    @user = User.find_by(id: decode_token(params[:token])["user_id"])

    unless @user.present?
      flash[:alert] = "Invalid/expired token, please try again."
      redirect_to new_password_resets_path
    end
  end
end