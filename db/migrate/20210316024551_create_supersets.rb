class CreateSupersets < ActiveRecord::Migration[6.1]
  def change
    create_table :supersets do |t|
      t.string :name
      t.references :workout, null: false, foreign_key: true
      t.integer :position
      t.integer :rest_time

      t.timestamps
    end
  end
end
