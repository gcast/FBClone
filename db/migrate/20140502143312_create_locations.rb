class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.float :long, null: false
    	t.float :lat, null: false
    	t.references :locationable, polymorphic: true
      	t.timestamps
    end
  end
end
