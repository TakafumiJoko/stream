class ChangeS3filesToVideos < ActiveRecord::Migration[6.0]
  def change
    rename_table :s3files, :videos
  end
end
