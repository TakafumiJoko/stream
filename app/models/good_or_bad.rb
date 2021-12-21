class GoodOrBad < ApplicationRecord
  belongs_to :user
  belongs_to :video
  enum type: { good: 0, bad: 1 }
  
  def self.count(video)
    @good_count = 0
    good = GoodOrBad.where(video_id: video.id).where(evaluation_type: 0)
    good.each do
      @good_count += 1
    end
    @bad_count = 0
    bad = GoodOrBad.where(video_id: video.id).where(evaluation_type: 1)
    bad.each do
      @bad_count += 1
    end
  end
end
