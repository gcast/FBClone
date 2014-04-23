class CreateFriendGroupJoins < ActiveRecord::Migration
  def change
    create_table :friend_group_joins do |t|
    	t.integer :group_id, null: false
    	t.integer :friend_id, null: false
    	t.integer :owner_id, null: false
      	t.timestamps
    end

    add_index :friend_group_joins, :group_id
    add_index :friend_group_joins, :friend_id
    add_index :friend_group_joins, :owner_id
    add_index :friend_group_joins, [:group_id, :friend_id, :owner_id], unique: true
  end
end
