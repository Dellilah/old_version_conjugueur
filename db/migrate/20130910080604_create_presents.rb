class CreatePresents < ActiveRecord::Migration
  def change
    create_table :presents do |t|
      t.string :je
      t.string :tu
      t.string :il
      t.string :nous
      t.string :vous
      t.string :ils
      t.integer :verb_id

      t.timestamps
    end

    add_foreign_key :presents, :verbs
  end
end
