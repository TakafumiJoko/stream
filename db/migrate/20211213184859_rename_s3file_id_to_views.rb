class RenameS3fileIdToViews < ActiveRecord::Migration[6.0]
  def change
    rename_column :views, :s3file_id, :video_id
  end
end
