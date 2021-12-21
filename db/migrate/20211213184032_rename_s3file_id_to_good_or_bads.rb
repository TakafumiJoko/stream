class RenameS3fileIdToGoodOrBads < ActiveRecord::Migration[6.0]
  def change
    rename_column :good_or_bads, :s3file_id, :video_id
  end
end
