class Workout < ApplicationRecord
  has_many :supersets, dependent: :destroy
  belongs_to :program
end
