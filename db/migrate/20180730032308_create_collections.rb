class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.string :description
      t.references :user, null: false

      t.timestamps
    end
    # add_index :collections, :user_id
  end
end
