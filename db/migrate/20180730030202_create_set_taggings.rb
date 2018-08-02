class CreateSetTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :set_taggings do |t|
      t.references :user, null: false
      t.references :tag_set, null: false
      t.references :tag, null: false
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end
    add_index :set_taggings, [:tag_set_id, :tag_id], unique: true
    # add_index :set_taggings, :tag_id
  end
end
