class AddAcceptToMembership < ActiveRecord::Migration
  def self.up
    add_column :memberships, :accept, :boolean
  end

  def self.down
    remove_column :memberships, :accept
  end
end
