class ProgramsController < ApplicationController
  def index
    programs = Program.all

    programs_json = programs.as_json(include: { program_days: { only: [:name, :position, :id] } })
    render json: programs_json
  end

  def show
    program = Program.find(params[:id])

    program_json = program.as_json(include: { program_days: {
                                     include: { program_supersets: {
                                       include: :program_lifts,
                                     } },
                                   } })

    render json: program_json
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
