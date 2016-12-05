class AddUserIdToEducationalDetails < ActiveRecord::Migration
  def change
  	add_column :educational_details, :user_id, :integer
    add_index :educational_details, :user_id
  end
end
