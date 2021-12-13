class RenameS3fileIdToOneDayViews < ActiveRecord::Migration[6.0]
  def change
    rename_column :one_day_views, :s3file_id, :video_id
  end
end
