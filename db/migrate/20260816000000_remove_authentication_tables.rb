class RemoveAuthenticationTables < ActiveRecord::Migration[8.0]
  def up
    drop_table :user_records, if_exists: true
    drop_table :users, if_exists: true
  end

  def down
    create_table :users do |t|
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :user_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :record, null: false, foreign_key: true
      t.timestamps
    end
  end
end
