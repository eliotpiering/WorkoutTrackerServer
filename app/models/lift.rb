class Lift < ApplicationRecord
  belongs_to :exercise
  belongs_to :superset
  has_many :lift_attempts, dependent: :destroy
end
