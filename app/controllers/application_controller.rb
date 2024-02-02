class ApplicationController < ActionController::Base
  include ExceptionHandler

  private

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "You must be logged in to perform this action" 
      redirect_to root_path 
    end
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def login(user)
    binding.pry
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end

  def reset_session
    session[:user_id] = nil
  end

  def create_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def decode_token(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    rescue JWT::DecodeError
      nil
    end
  end
end
