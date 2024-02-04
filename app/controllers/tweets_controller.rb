class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_user.twitter_accounts.find(params[:twitter_account_id]).tweets
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def tweets_params
    params.require(:tweet).permit()
  end
end