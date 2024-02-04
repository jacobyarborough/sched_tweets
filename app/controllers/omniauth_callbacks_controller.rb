class OmniauthCallbacksController < ApplicationController
  def twitter2
    # Rails.logger.info auth
    current_user.twitter_accounts.find_or_create_by( # maybe should do where().first_or_initialize
      uid: auth.uid,
      name: auth.info.name,
      username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      expires_at: auth.info.expires_at
    )

    flash[:notice] = "Successfully connected twitter account"
    redirect_to twitter_accounts_path
  end

  def auth
    request.env['omniauth.auth']
  end
end