class Video < ApplicationRecord
  belongs_to :channel
  has_many :comments, dependent: :destroy
  has_many :histories
  has_one :view
  has_one :one_day_view
  has_many :good_or_bads
  has_many :video_tags
  has_many :tags, through: :video_tags
  enum category: [:music, :movie, :program, :game, :news, :sports, :learning]
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old|
      self.tags.delete(Tag.find_by(tag_name: old))
    end
    
    new_tags.each do |new|
      unless new_tag = Tag.find_by(tag_name: new)
        new_tag = Tag.create(video_id: self.id, tag_name: new)
      end
      self.tags << new_tag
    end
  end
end
