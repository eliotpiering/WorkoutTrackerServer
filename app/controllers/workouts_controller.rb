class WorkoutsController < ApplicationController
  def index
    workouts = Workout.all

    render json: workouts
  end

  def show
    workout = Workout.find(params[:id])

    #video_urls = ["http://192.168.1.186:8080/1_2%20Kneeling%20Single%20Arm%20Landmine%20Press-MXN7i0DAmCc.mkv", "http://192.168.1.186:8080/1_2%20Kneeling%20Single%20Arm%20Overhead%20Press%20vs.%20Wall-EdNWweKV9XE.mkv", "http://192.168.1.186:8080/Heels%20Dug%20In%20Bridge%20Iso-sB_cBt378Jc.mp4", "http://192.168.1.186:8080/High%20Incline%20Dumbbell%20Stability%20Press-_z-O0u_Idh4.mkv", "http://192.168.1.186:8080/Standing%20Overhead%20Barbell%20Press-3WVZYn4Sny8.mp4", "http://192.168.1.186:8080/Seated%20Overhead%20Barbell%20Press%20_%20Barbell%20Z-Press-HlHpxCC6b84.mkv", "http://192.168.1.186:8080/Incline%20Dumbbell%20Press-pnmdS4pB4CU.mkv"]

    workout_json = workout.as_json(include: { supersets: {
                                     include: { lifts: {
                                       include: [:lift_attempts, { exercise: { only: [:id] } }],
                                     } },
                                   } })

    exercise_ids = workout_json["supersets"].flat_map { |s| s["lifts"].collect { |la| la["exercise"]["id"] } }.uniq
    exercises = Exercise.where(id: exercise_ids)
    exercise_json = exercises.as_json(methods: [:video_url])

    workout_json.merge!({ exercises: exercise_json })

    render json: workout_json
  end
end
