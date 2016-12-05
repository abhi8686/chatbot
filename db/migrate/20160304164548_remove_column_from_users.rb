class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :oauth_token
  	remove_column :users, :oauth_secret
  	remove_column :users, :provider
  	remove_column :users, :uid
  end
end
