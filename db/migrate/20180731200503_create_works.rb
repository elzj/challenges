class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title, null: false, default: ''
      t.text :body
      t.references :user #, foreign_key: true
      t.references :prompt

      t.timestamps
    end
  end
end
