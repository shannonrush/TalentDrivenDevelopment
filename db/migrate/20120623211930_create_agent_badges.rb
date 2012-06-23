class CreateAgentBadges < ActiveRecord::Migration
  def change
    create_table :agent_badges, :id => false do |t|
      t.references :agent
      t.references :badge
      t.timestamps
    end
  end
end
