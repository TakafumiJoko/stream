class AddUserIdToVideos < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :user_id
    add_reference :videos, :user
  end
end
