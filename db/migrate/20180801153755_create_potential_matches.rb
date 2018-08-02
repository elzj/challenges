class CreatePotentialMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :potential_matches do |t|
      t.references :challenge_signup, foreign_key: true
      t.references :challenge, foreign_key: true
      t.integer :total_matches, null: false, default: 0
      t.text :matches

      t.timestamps
    end
  end
end
