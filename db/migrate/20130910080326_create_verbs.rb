class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :infinitive
      t.integer :group
      t.string :translation
      t.timestamps
    end
    add_index :verbs, :infinitive, :unique => true
  end
end
