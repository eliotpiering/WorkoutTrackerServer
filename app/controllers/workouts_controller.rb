class WorkoutsController < ApplicationController
  def index
    workouts = Workout.all

    render json: workouts
  end

  def show
    workout = Workout.find(params[:id])

    render json: workout.as_json(include: { supersets: {
                                   include: { lifts: {
                                     include: [:lift_attempts, { exercise: { only: [:id, :name] } }],
                                   } },
                                 } })
  end
end
