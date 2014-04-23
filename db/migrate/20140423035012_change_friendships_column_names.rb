class ChangeFriendshipsColumnNames < ActiveRecord::Migration
  def change
  	rename_column :friendships, :userID, :user_id
  	rename_column :friendships, :friendID, :friend_id
  end
end

