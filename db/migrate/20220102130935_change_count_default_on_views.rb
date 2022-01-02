class ChangeCountDefaultOnViews < ActiveRecord::Migration[6.0]
  def change
    change_column_default :views, :count, from: nil, to: 0
  end
end
