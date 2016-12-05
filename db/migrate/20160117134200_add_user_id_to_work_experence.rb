class AddUserIdToWorkExperence < ActiveRecord::Migration
  def change
  	add_column :work_experiences, :user_id, :integer
    add_index :work_experiences, :user_id
  end
end
