class CreateMandalartMains < ActiveRecord::Migration[6.0]
  def change
    create_table :mandalart_mains do |t|
      t.bigint :user_id,              null: false
      t.string :goal,              null: false
      t.bigint :mandalart_sub_id_1,   null: true
      t.bigint :mandalart_sub_id_2,   null: true
      t.bigint :mandalart_sub_id_3,   null: true
      t.bigint :mandalart_sub_id_4,   null: true
      t.bigint :mandalart_sub_id_5,   null: true
      t.bigint :mandalart_sub_id_6,   null: true
      t.bigint :mandalart_sub_id_7,   null: true
      t.bigint :mandalart_sub_id_8,   null: true
      t.timestamps
    end
  end
end
