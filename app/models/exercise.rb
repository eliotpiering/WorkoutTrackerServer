class Exercise < ApplicationRecord
  has_one_attached :video, dependent: :destroy

  def video_url
    #Rails.application.routes.url_helpers.rails_blob_path(user.avatar)
    return nil unless video.attached?
    video.blob.url
  end
end
