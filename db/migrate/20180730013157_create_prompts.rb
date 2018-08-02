class CreatePrompts < ActiveRecord::Migration[5.2]
  def change
    create_table :prompts do |t|
      t.references :user, null: false
      t.integer :assignee_id
      t.text :body
      t.integer :challenge_id
      t.boolean :fulfilled, null: false, default: false
      t.boolean :offer, null: false, default: false      

      t.timestamps
    end
    add_index :prompts, [:challenge_id, :user_id]
    add_index :prompts, [:challenge_id, :assignee_id]    
    # add_index :prompts, :user_id
    add_index :prompts, :assignee_id
  end
end
