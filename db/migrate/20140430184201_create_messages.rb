class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :thread_id, null: false
    	t.text :message, null: false
    	t.integer :sender_id, null: false
    	t.integer :recipient_id, null: false
    	t.boolean :is_read, null: false, default: false
      	t.timestamps
    end

    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, :thread_id
  end
end
