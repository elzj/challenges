class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, null: false, default: ''
      t.string :type, null: false, default: ''
      t.boolean :canonical, null: false, default: false

      t.timestamps
    end
    add_index :tags, [:type, :name], unique: true
  end
end
