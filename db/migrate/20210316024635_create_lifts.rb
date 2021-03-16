class CreateLifts < ActiveRecord::Migration[6.1]
  def change
    create_table :lifts do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :superset, null: false, foreign_key: true
      t.integer :position
      t.boolean :left_and_right, default: false

      t.timestamps
    end
  end
end
