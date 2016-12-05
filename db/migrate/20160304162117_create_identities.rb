class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :oauth_token_facebook
      t.string :oauth_token_twitter
      t.string :oauth_secret_twitter
      t.references :user

      t.timestamps null: false
    end

    add_index :identities, :user_id
  end
end
