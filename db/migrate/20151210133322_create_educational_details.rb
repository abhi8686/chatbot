class CreateEducationalDetails < ActiveRecord::Migration
  def change
    create_table :educational_details do |t|
      t.string :collageName
      t.string :courseName
      t.string :location

      t.timestamps null: false
    end
  end
end
