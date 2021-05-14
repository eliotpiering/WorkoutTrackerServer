class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.integer :weeks
      t.integer :workouts_per_week
      t.string :name

      t.timestamps
    end
  end
end
