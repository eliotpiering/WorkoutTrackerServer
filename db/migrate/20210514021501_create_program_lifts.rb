class CreateProgramLifts < ActiveRecord::Migration[6.1]
  def change
    create_table :program_lifts do |t|
      t.references :program_superset, null: false, foreign_key: true
      t.references :exercise, null: true, foreign_key: true
      t.integer :position
      t.json :weekly_lifts

      t.timestamps
    end
  end
end
