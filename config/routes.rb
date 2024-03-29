Rails.application.routes.draw do
  root "main#index"
  get '/about', to: "about#index"
  
  resource :registrations, only: [:new, :create]
  resource :sessions, only: [:new, :create, :destroy]
  resource :password_resets
  resource :passwords

  get '/auth/twitter2/callback', to: 'omniauth_callbacks#twitter2'

  resources :twitter_accounts, only: [:index, :destroy] do
    resources :tweets, except: [:show]
    get '/my_tweets', to: "tweets#my_tweets"
  end

  # get '/twitter_accounts/:twitter_account_id/my_tweets', to: "tweets#my_tweets"
end
