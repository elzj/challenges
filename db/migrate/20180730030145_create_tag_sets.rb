class CreateTagSets < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_sets do |t|
      t.references :challenge
      t.boolean :accepting_noms, null: false, default: false

      t.timestamps
    end
    # add_index :tag_sets, :challenge_id
  end
end
