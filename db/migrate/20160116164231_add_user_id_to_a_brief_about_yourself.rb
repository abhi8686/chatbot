class AddUserIdToABriefAboutYourself < ActiveRecord::Migration
  def change
  	add_column :a_brief_about_yourselves, :user_id, :integer
    add_index :a_brief_about_yourselves, :user_id
  end
end
