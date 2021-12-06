class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :user
      t.references :s3file
      t.timestamps
    end
  end
end
