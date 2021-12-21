class RenameS3fileIdToHistories < ActiveRecord::Migration[6.0]
  def change
    rename_column :histories, :s3file_id, :video_id
  end
end
