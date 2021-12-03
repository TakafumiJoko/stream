class ChangeColumnsToHistories < ActiveRecord::Migration[6.0]
  def change
    remove_column :histories, :watched_by_id, :integer
    add_reference :histories, :user
  end
end