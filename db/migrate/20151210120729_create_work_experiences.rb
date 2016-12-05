class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.string :companyName
      t.string :designation
      t.string :location

      t.timestamps null: false
    end
  end
end
