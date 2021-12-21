class View < ApplicationRecord
  belongs_to :video
  def self.count(video)
    if view = View.find_by(video_id: video.id)
      count = view.count + 1
      view.update_attribute(:count, count)
    else
      View.create(video_id: video.id, count: 0)
    end
  end
end
