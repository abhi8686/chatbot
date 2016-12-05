class AddFinalDateTwitterToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :final_date_twitter, :datetime
  end
end
