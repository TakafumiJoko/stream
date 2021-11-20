class RemoveNameFromS3files < ActiveRecord::Migration[6.0]
  def change
    remove_column :s3files, :name, :string
  end
end
