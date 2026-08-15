class AddAccessTokenToRecords < ActiveRecord::Migration[8.0]
  def up
    add_column :records, :access_token, :string
    Record.reset_column_information
    Record.find_each { |record| record.update_columns(access_token: SecureRandom.urlsafe_base64(24)) }
    change_column_null :records, :access_token, false
    add_index :records, :access_token, unique: true
  end

  def down
    remove_index :records, :access_token
    remove_column :records, :access_token
  end
end
