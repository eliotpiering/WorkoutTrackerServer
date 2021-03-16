# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require("csv")

def process_from_csv(filename)
  ActiveRecord::Base.transaction do
    workout = Workout.new
    superset_position = 0
    lift_position = 0
    lift_attempt_position = 0
    superset = nil
    lift = nil

    CSV.read(filename, headers: true).each do |row|
      if row[0].match(/SUPERSET_START/)
        superset = Superset.create!(workout: workout, name: row[1], position: superset_position, rest_time: row[2])
        superset_position += 1
        next
      end

      exercise = Exercise.find_or_create_by!(name: row[0])
      lift = Lift.create!(exercise: exercise, superset: superset, position: lift_position)
      lift_attempt_position = 0
      row[2..].each_slice(3) do |target_reps, target_weight, target_time|
        LiftAttempt.create!(lift: lift, target_reps: target_reps, target_weight: target_weight, target_time: target_time, position: lift_attempt_position)
        lift_attempt_position += 1
      end

      lift_position += 1
    end
    workout.save!
  end
end

process_from_csv(
  Rails.root.join("db", "./week3-day1.csv")
)
