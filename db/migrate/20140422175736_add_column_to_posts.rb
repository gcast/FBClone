class AddColumnToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :recipient_id, :integer
  end
end
