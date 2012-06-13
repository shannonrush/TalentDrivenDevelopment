class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :background, :text
    add_column :users, :statement, :text
  end
end
