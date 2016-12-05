class AddFinalDateToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :final_date, :datetime
  end
end
