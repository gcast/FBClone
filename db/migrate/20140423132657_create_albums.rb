class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    	t.integer :owner_id, null: false
    	t.string :name, null: false
      	t.timestamps
    end

    add_index :albums, :owner_id
  end
end
