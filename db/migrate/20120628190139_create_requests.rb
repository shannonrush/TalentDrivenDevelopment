class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :talent_id
      t.integer :agent_id
      t.text :message
      t.boolean :accepted
      t.boolean :pending

      t.timestamps
    end
  end
end
