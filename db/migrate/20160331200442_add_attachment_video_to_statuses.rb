class AddAttachmentVideoToStatuses < ActiveRecord::Migration
  def self.up
    change_table :statuses do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :statuses, :video
  end
end
