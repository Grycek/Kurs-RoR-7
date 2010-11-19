class AddUserIdAndGroupIdAndAdminToMembership < ActiveRecord::Migration
  def self.up
    add_column :memberships, :user_id, :integer
    add_column :memberships, :group_id, :integer
    add_column :memberships, :admin, :boolean
  end

  def self.down
    remove_column :memberships, :admin
    remove_column :memberships, :group_id
    remove_column :memberships, :user_id
  end
end
