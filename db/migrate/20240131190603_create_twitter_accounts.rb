class CreateTwitterAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :twitter_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :username
      t.string :token
      # t.string :secret
      t.string :image
      t.bigint :expires_at
      t.string :uid


      t.timestamps
    end
  end
end
