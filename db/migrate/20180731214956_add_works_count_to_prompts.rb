class AddWorksCountToPrompts < ActiveRecord::Migration[5.2]
  def change
    add_column :prompts, :works_count, :integer, null: false, default: 0
  end
end
