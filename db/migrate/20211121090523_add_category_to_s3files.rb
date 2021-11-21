class AddCategoryToS3files < ActiveRecord::Migration[6.0]
  def change
    add_column :s3files, :category, :integer
  end
end
