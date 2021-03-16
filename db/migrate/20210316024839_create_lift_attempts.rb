class CreateLiftAttempts < ActiveRecord::Migration[6.1]
  def change
    create_table :lift_attempts do |t|
      t.references :lift, null: false, foreign_key: true
      t.integer :target_reps
      t.integer :target_weight
      t.integer :target_time
      t.integer :reps
      t.integer :weight
      t.integer :time
      t.integer :position

      t.timestamps
    end
  end
end
