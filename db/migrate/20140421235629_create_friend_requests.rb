class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
    	t.integer :requestorID
    	t.integer :requesteeID
      	t.timestamps
    end
  end
end
