class AddAgentReferenceToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :agent
    end
  end
end
