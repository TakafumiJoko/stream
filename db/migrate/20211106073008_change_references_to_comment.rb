class ChangeReferencesToComment < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :video_id
    add_reference :comments, :user
    add_reference :comments, :video
  end
end
