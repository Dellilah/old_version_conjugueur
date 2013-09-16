class AddTranslationToVerbs < ActiveRecord::Migration
  def change
    add_column :verbs, :translation, :string
  end
end
