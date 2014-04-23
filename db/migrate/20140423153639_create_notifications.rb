class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :event_id
    	t.integer :user_id
    	t.references :notifiable, polymorphic: true
      	t.timestamps
    end
  end
end
