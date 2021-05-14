class ProgramDay < ApplicationRecord
  belongs_to :program
  has_many :program_supersets

  DEFAULT_SUPERSET_COUNT = 3

  def self.generate_workouts_for!(program, day_number)
    day = ProgramDay.create!(program: program, name: "Day #{day_number + 1}", position: day_number)
    DEFAULT_SUPERSET_COUNT.times do |superset_number|
      ProgramSuperset.generate_workouts_for!(program, day, superset_number)
    end
  end
end
