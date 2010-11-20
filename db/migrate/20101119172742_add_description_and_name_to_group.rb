class AddDescriptionAndNameToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :description, :text
    add_column :groups, :name, :string
  end

  def self.down
    remove_column :groups, :name
    remove_column :groups, :description
  end
end
