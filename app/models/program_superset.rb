class ProgramSuperset < ApplicationRecord
  belongs_to :program_day
  has_many :program_lifts

  DEFAULT_LIFT_COUNT = 3

  def self.generate_workouts_for!(program, day, superset_number)
    superset = ProgramSuperset.create!(program_day: day,
                                       name: "Block #{superset_number + 1}",
                                       position: superset_number)
    DEFAULT_LIFT_COUNT.times.collect do |lift_number|
      ProgramLift.generate_workouts_for!(program, day, superset, lift_number)
    end
  end
end
