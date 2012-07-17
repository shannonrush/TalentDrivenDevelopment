class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :agent_id
      t.integer :talent_id
      t.string :entity
      t.text :description
      t.boolean :acceptable
      t.boolean :accepted

      t.timestamps
    end
  end
end
