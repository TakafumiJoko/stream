class RenameWatchedByColumnToHistories < ActiveRecord::Migration[6.0]
  def change
    remove_column :histories, :watched_by_id
    add_reference :histories, :user
  end
end
