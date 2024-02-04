class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.text :body
      t.datetime :publish_at
      t.references :user, null: false, foreign_key: true
      t.string :tweet_id
      t.references :twitter_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
