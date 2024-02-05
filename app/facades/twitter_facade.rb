class TwitterFacade
  def self.get_tweets(user, twitter_account)
    TwitterService.get_tweets(user, twitter_account)
  end
end