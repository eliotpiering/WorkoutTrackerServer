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
    workout = Workout.new(name: filename.basename.to_s)
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
      if row[1].present? && !exercise.video.attached?
        set_video(exercise, row[1])
        exercise.save!
      end

      lift = Lift.create!(exercise: exercise, superset: superset, position: lift_position)
      lift_attempt_position = 0
      row[3..].each_slice(3) do |target_reps, target_weight, target_time|
        next if target_reps.blank? && target_weight.blank? && target_time.blank?

        LiftAttempt.create!(lift: lift, target_reps: target_reps, target_weight: target_weight, target_time: target_time, position: lift_attempt_position)
        lift_attempt_position += 1
      end

      lift_position += 1
    end
    workout.save!
  end
end

def download_from_youtube(url)
  youtube_download_cmd = "youtube-dl -o './tmp/%(title)s.%(ext)s' --restrict-filenames #{url}"
  output = []
  output_url = ""
  IO.popen(youtube_download_cmd).each do |line|
    output << line
    if (match = line.match(/Merging formats into "(.*)"/))
      output_url = match[1]
    elsif (match = line.match(/\[download\]\s(.*)\shas already been downloaded and merged/))
      output_url = match[1]
    end
  end
  raise "NO OUTPUT URL FOUND FOR #{output}" if output_url.blank?

  output_url
end

def set_video(exercise, filename)
  path = if filename.match("youtube.com")
      Rails.root.join(download_from_youtube(filename))
    else
      Rails.root.join(File.join(["test_videos", "Verticle_Pressing", filename]))
    end

  raise "BAD PATH #{path}" unless path.exist?

  exercise.video.attach(io: File.open(path), filename: exercise.name.gsub(" ", "-"))
end

filename = ENV["SEED_CSV"]
raise "set SEED_CSV" if filename.blank?

process_from_csv(Rails.root.join("db", filename))
