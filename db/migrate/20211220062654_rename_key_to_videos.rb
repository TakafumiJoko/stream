class RenameKeyToVideos < ActiveRecord::Migration[6.0]
  def up
    change_column :videos, :key, :title
  end
end
