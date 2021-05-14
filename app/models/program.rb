class Program < ApplicationRecord
  has_many :program_days

  def self.generate_workouts_for!(program)
    ActiveRecord::Base.transaction do
      program.workouts_per_week.times do |day_number|
        ProgramDay.generate_workouts_for!(program, day_number)
      end
    end
    program.reload!
  end
end
