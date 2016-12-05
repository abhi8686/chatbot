class AddImageToStatuses < ActiveRecord::Migration
  def change
  	add_attachment :statuses, :image
  end
end
