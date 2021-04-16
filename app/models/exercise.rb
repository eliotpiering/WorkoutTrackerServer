class Exercise < ApplicationRecord
  has_one_attached :video, dependent: :destroy
end
