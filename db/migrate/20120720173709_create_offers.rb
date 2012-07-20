class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :agent_id
      t.integer :talent_id
      t.string :entity
      t.text :description
      t.text :comment
      t.boolean :acceptable
      t.boolean :accepted

      t.timestamps
    end
  end
end
