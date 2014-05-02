class AddStringLocationToLocation < ActiveRecord::Migration
  def change
  	add_column :locations, :location_string, :string
  end
end
