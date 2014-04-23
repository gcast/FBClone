class RenameFriendRequestColumns < ActiveRecord::Migration
  def change
  	rename_column :friend_requests, :requestorID, :requestor_id
  	rename_column :friend_requests, :requesteeID, :requestee_id
  end
end
