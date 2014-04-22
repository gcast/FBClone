class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :firstName, null: false
    t.string :lastName, null: false
    t.string :email, null: false
    t.string :password_digest, null: false
    t.date :birthDate, null: false
    t.string :session_token, null: false
    t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
