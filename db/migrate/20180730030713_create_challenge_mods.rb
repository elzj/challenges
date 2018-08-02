class CreateChallengeMods < ActiveRecord::Migration[5.2]
  def change
    create_table :challenge_mods do |t|
      t.references :user, null: false
      t.references :challenge, null: false

      t.timestamps
    end
    add_index :challenge_mods, [:challenge_id, :user_id], unique: true
    # add_index :challenge_mods, :user_id
  end
end
