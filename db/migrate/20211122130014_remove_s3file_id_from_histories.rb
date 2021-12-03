class RemoveS3fileIdFromHistories < ActiveRecord::Migration[6.0]
  def change
    remove_column :histories, :s3file_id
  end
end
