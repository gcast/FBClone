class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
    	t.string :ip_address
      	t.timestamps
    end
  end
end
