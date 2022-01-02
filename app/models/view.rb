class View < ApplicationRecord
  belongs_to :video
  def self.count(video)
    if view = View.find_or_initialize_by(video_id: video.id)
      count = view.count + 1
      view.update_attribute(:count, count)
    end
  end
end
