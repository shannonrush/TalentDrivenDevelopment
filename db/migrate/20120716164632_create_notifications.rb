class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :agent_id
      t.integer :talent_id

      t.timestamps
    end
  end
end
