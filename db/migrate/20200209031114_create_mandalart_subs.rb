class CreateMandalartSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :mandalart_subs do |t|
      t.bigint :mandalart_main_id,     null: false
      t.string :goal_sub,           null: false
      t.string :term1,              null: false
      t.string :term2,              null: false
      t.string :term3,              null: false
      t.string :term4,              null: false
      t.string :term5,              null: false
      t.string :term6,              null: false
      t.string :term7,              null: false
      t.string :term8,              null: false
      t.timestamps
    end
  end
end
