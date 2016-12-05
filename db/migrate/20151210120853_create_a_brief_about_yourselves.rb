class CreateABriefAboutYourselves < ActiveRecord::Migration
  def change
    create_table :a_brief_about_yourselves do |t|
      t.text :body
      t.timestamps null: false
    end
  end
end
