class RenameImageToVideos < ActiveRecord::Migration[6.0]
  def change
    rename_column :videos, :image, :thumbnail
  end
end
