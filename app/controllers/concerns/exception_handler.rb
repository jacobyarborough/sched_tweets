module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from JWT::DecodeError do |e|
      flash[:alert] = "Token is invalid/expried"
      redirect_to new_password_resets_path, status: :bad_request
    end
  end
end