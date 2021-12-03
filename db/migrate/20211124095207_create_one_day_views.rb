class CreateOneDayViews < ActiveRecord::Migration[6.0]
  def change
    create_table :one_day_views do |t|
      t.references :s3file, null: false, foreign_key: true
      t.integer :count
      
      t.timestamps
    end
  end
end
