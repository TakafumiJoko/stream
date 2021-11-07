class AddUserToVideo < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :user
  end
end
