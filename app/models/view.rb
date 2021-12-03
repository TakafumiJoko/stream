class View < ApplicationRecord
  belongs_to :s3file
  def self.count_view(s3file)
    if view = View.find_by(s3file_id: s3file.id)
      count = view.count + 1
      view.update_attribute(:count, count)
    else
      View.create(s3file_id: s3file.id, count: 0)
    end
  end
end
