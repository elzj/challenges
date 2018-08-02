class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :type, null: false
      t.references :user
      t.string :name, null: false, default: ''
      t.text :description
      t.text :rules
      t.boolean :active, null: false, default: true
      t.integer :collection_id

      t.timestamps
    end
    add_index :challenges, :collection_id
    # add_index :challenges, :user_id
    add_index :challenges, :type
  end
end
