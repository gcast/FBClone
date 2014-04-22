class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
    	t.integer :post_id, null: false
    	t.integer :tagged_user_id, null: false
      	t.timestamps
    end

    add_index :post_tags, :post_id
    add_index :post_tags, :tagged_user_id
    add_index :post_tags, [:post_id, :tagged_user_id], unique: true
  end
end
