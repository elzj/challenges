class CreateChallengeSignups < ActiveRecord::Migration[5.2]
  def change
    create_table :challenge_signups do |t|
      t.references :challenge, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :approved, null: false, default: false
      t.boolean :complete, null: false, default: false

      t.timestamps
    end
    add_column :prompts, :signup_id, :integer
    add_index :prompts, :signup_id
  end
end
