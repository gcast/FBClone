class RemoveOwnerIdFromGroupJoin < ActiveRecord::Migration
  def change
  	remove_column :friend_group_joins, :owner_id
  end
end
