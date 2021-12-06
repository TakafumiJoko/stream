class OneDayView < ApplicationRecord
  belongs_to :s3file
  
  def self.count(s3file)
    if view = OneDayView.find_by(s3file_id: s3file.id)
      count = view.count + 1
      view.update_attribute(:count, count)
    else
      OneDayView.create(s3file_id: s3file.id, count: 0)
    end
  end
end
