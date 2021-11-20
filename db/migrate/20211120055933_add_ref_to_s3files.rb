class AddRefToS3files < ActiveRecord::Migration[6.0]
  def change
    add_reference :s3files, :channel, null: true, foreign_key: true
  end
end
