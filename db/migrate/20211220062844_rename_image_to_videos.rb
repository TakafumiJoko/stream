class RenameImageToVideos < ActiveRecord::Migration[6.0]
  def up
    change_column :videos, :image, :thumbnail
  end
end
