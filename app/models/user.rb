class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  # normalizes :email, with: ->(email) { email.strip.downcase } rails 7.1
  # rails 7.1 generates_token_for :password_reset, expires_in: 15.minutes do 
  #   password_salt&.last(10)
  # end 
  # generates one-time use tokens (ex password reset)
  # current_user.to_sgid()
  
  has_many :twitter_accounts


  def email=(value)
    super(value.strip.downcase)
  end
end