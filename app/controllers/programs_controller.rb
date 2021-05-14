class ProgramsController < ApplicationController
  def index
    programs = Program.all

    render json: programs
  end

  def create
    program = Program.create!(program_params)
    Program.generate_workouts_for!(program)
  end

  private

  def program_params
    params.require(:program).permit(:name, :weeks, :workouts_per_week)
  end
end
