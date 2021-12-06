class AddS3fileIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :s3file
  end
end
