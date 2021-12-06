class GoodOrBad < ApplicationRecord
  belongs_to :user
  belongs_to :s3file
  enum type: { good: 0, bad: 1 }
  
  def self.count(s3file)
    @good_count = 0
    good = GoodOrBad.where(s3file_id: s3file.id).where(evaluation_type: 0)
    good.each do
      @good_count += 1
    end
    @bad_count = 0
    bad = GoodOrBad.where(s3file_id: s3file.id).where(evaluation_type: 1)
    bad.each do
      @bad_count += 1
    end
  end
end
