class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :infinitive
      t.integer :group

      t.timestamps
    end
    add_index :verbs, :infinitive, :unique => true
  end
end
