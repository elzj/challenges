class AddUsersToTagSets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tag_sets, :user, foreign_key: true
  end
end
