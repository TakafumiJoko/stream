class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :comment_id
      t.integer :commenter_id

      t.timestamps
    end
  end
end
