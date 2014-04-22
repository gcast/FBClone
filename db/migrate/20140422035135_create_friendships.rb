class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
    	t.integer :userID
    	t.integer :friendID
      	t.timestamps
    end

    add_index :friendships, [:userid, :friendid], unique: true
    add_index :friendships, :userID
    add_index :friendships, :friendID
  end
end
