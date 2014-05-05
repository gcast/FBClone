class AddSessionStatusToUsersTable < ActiveRecord::Migration
  def change
  	add_column :users, :session_active, :boolean, default: true
  end
end
