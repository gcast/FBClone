class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.attachment :file
    	t.references :imageable, polymorphic: true
      	t.timestamps
    end
  end
end
