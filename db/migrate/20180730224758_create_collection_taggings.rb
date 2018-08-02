class CreateCollectionTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_taggings do |t|
      t.references :tag, null: false #, foreign_key: true
      t.references :collection, null: false #, foreign_key: true

      t.timestamps
    end
    add_index :collection_taggings, [:collection_id, :tag_id], unique: true
  end
end
