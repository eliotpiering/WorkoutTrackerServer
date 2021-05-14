class CreateProgramSupersets < ActiveRecord::Migration[6.1]
  def change
    create_table :program_supersets do |t|
      t.references :program_day, null: false, foreign_key: true
      t.string :name
      t.integer :rest_period
      t.integer :position

      t.timestamps
    end
  end
end
