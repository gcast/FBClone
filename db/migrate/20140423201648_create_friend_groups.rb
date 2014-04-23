class CreateFriendGroups < ActiveRecord::Migration
  def change
    create_table :friend_groups do |t|
    	t.string :group_name
    	t.integer :owner_id
      	t.timestamps
    end

    add_index :friend_groups, :owner_id
  end
end
