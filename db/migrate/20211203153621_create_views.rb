class CreateViews < ActiveRecord::Migration[6.0]
  def change
    create_table :views do |t|
      t.integer :count
      t.integer :s3file_id

      t.timestamps
    end
  end
end
