class ChangeColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :image, :string
    add_column :users, :password, :string
  end
end
