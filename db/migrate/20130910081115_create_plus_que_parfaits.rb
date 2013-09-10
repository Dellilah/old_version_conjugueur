class CreatePlusQueParfaits < ActiveRecord::Migration
  def change
    create_table :plus_que_parfaits do |t|
      t.string :je
      t.string :tu
      t.string :il
      t.string :nous
      t.string :vous
      t.string :ils
      t.integer :verb_id

      t.timestamps
    end

    add_foreign_key :plus_que_parfaits, :verbs
  end
end
