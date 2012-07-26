class AddDescriptionToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :description, :text
  end
end
