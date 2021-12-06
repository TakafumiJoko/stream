class CreateGoodOrBads < ActiveRecord::Migration[6.0]
  def change
    create_table :good_or_bads do |t|
      t.references :user
      t.references :s3file
      
      t.timestamps
    end
  end
end
