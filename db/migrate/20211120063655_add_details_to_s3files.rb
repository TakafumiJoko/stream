class AddDetailsToS3files < ActiveRecord::Migration[6.0]
  def change
    add_column :s3files, :name, :string
    add_column :s3files, :image, :string
  end
end
