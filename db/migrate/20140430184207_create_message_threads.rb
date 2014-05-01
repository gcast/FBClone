class CreateMessageThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
    	t.integer :user_one, null: false
    	t.integer :user_two, null: false
      	t.timestamps
    end

    add_index :message_threads, :user_one
    add_index :message_threads, :user_two
  end
end
