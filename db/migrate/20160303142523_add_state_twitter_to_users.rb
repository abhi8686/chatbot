class AddStateTwitterToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :state_twitter, :boolean, default: false
  end
end
