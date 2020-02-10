class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.jsonb :data
      t.timestamps
    end
  end
end
