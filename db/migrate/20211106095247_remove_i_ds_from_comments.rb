class RemoveIDsFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :comment_id
    remove_column :comments, :commenter_id
  end
end
