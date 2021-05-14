class CreateProgramDays < ActiveRecord::Migration[6.1]
  def change
    create_table :program_days do |t|
      t.references :program, null: false, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
