class CreatePromptTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :prompt_taggings do |t|
      t.references :prompt, null: false
      t.references :tag, null: false

      t.timestamps
    end
    add_index :prompt_taggings, [:prompt_id, :tag_id], unique: true
  end
end
