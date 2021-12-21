class RenameKeyToVideos < ActiveRecord::Migration[6.0]
  def change
    rename_column :videos, :key, :title
  end
end
