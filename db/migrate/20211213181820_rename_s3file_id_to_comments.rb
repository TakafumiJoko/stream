class RenameS3fileIdToComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :s3file_id, :video_id
  end
end
