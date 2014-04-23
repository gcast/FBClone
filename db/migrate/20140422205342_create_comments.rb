class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :comment
    	t.references :commentable, polymorphic: true
    	t.integer :author_id
      	t.timestamps
    end

    add_index :comments, :author_id
  end
end
