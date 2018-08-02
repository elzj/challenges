class AddDeadlineToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :deadline, :datetime
  end
end
