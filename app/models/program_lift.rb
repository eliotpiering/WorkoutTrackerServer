class ProgramLift < ApplicationRecord
  belongs_to :program_superset
  belongs_to :exercise, optional: true

  DEFAULT_SET_COUNT = 3

  def self.generate_workouts_for!(program, _day, superset, lift_number)
    ProgramLift.create!(
      program_superset: superset,
      position: lift_number,
      weekly_lifts: program.weeks.times.collect do
        DEFAULT_SET_COUNT.times.collect do
          { reps: 12, weight: nil, time: nil }
        end
      end,
    )
  end

  def weekly_lift_count
    program_superset.program_day.program.weeks
  end
end
