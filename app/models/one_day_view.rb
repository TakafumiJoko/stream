class OneDayView < ApplicationRecord
  belongs_to :video
  
  def self.count(video)
    if view = OneDayView.find_by(video_id: video.id)
      count = view.count + 1
      view.update_attribute(:count, count)
    else
      OneDayView.create(video_id: video.id, count: 0)
    end
  end
end
