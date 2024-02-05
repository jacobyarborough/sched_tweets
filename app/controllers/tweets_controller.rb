class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    twitter_account = current_user.twitter_accounts.find(params[:twitter_account_id])
    TwitterFacade.get_tweets(current_user, twitter_account)
    # current_user.twitter_accounts.find(params[:twitter_account_id]).tweets
  end

  def my_tweets
    @tweets = current_user.twitter_accounts.find(params[:twitter_account_id]).tweets
  end

  def new
    @tweet = current_user.twitter_accounts.find(params[:twitter_account_id]).tweets.new()
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.update(tweet_params)
      flash[:notice] = "Tweet has been successfully updated"
      redirect_to twitter_account_my_tweets_path(current_user.twitter_accounts.find(params[:twitter_account_id]))
    else
      render :edit, status: :unprocessable_entity
    end 
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    @tweet.twitter_account_id = params[:twitter_account_id]

    if @tweet.save
      flash[:notice] = "successfully scheduled the tweet!"
      redirect_to twitter_account_my_tweets_path(current_user.twitter_accounts.find(params[:twitter_account_id]))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Tweet.find(params[:id]).destroy
    flash[:notice] = "Successfully deleted tweet"
    redirect_to twitter_account_my_tweets_path(current_user.twitter_accounts.find(params[:twitter_account_id]))
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :publish_at)
  end
end