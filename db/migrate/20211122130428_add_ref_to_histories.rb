class AddRefToHistories < ActiveRecord::Migration[6.0]
  def change
    add_reference :histories, :s3file, null: false, foreign_key: true
  end
end
