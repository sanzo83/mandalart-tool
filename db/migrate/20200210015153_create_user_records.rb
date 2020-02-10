class CreateUserRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :user_records do |t|
      t.references :user, index: true, null: false
      t.references :record, index: true, null: false
      t.timestamps
    end
  end
end
