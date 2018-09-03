class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :session_token
      t.integer :region_id
      
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
    add_index :admins, :session_token, unique: true
    add_index :admins, :email, unique: true
    add_index :admins, :region_id
  end
end