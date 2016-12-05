class AddStateFacebookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state_facebook, :boolean, default: false
  end
end
