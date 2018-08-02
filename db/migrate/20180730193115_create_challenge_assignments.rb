class CreateChallengeAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :challenge_assignments do |t|
      t.references :challenge, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :signup_id
      t.integer :assignment_id
      t.datetime :sent_at
      t.integer :work_id

      t.timestamps
    end
    add_index :challenge_assignments, :signup_id
    add_index :challenge_assignments, :assignment_id
  end
end
