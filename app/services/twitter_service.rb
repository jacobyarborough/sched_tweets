class TwitterService
  class << self
    def get_tweets(user, twitter_account)
      binding.pry
      response = conn.get("/2/users/#{twitter_account.uid}/timelines/reverse_chronological") do |req|
        req.headers =  {
          'Authorization' => "Bearer #{twitter_account.token}"
        }
      end 



      parse_data(response)

      binding.pry
    end

    private

    def conn
      Faraday.new(
        url: "https://api.twitter.com",
        headers: {
          'Content-Type' => 'application/json'
        }
      )
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end