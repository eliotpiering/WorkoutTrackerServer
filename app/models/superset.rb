class Superset < ApplicationRecord
  belongs_to :workout
  has_many :lifts
end
