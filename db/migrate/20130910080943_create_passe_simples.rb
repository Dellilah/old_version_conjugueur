class CreatePasseSimples < ActiveRecord::Migration
  def change
    create_table :passe_simples do |t|
      t.string :je
      t.string :tu
      t.string :il
      t.string :nous
      t.string :vous
      t.string :ils
      t.integer :verb_id

      t.timestamps
    end

    add_foreign_key :passe_simples, :verbs
  end
end
