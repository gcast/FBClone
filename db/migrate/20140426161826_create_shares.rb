class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
    	t.integer :group_id, null: false
    	t.references :shareable, polymorphic: true
      	t.timestamps
    end

    add_index :shares, :group_id
  end
end
