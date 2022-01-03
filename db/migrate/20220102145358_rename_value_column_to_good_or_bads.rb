class RenameValueColumnToGoodOrBads < ActiveRecord::Migration[6.0]
  def change
    rename_column :good_or_bads, :value, :evaluation
  end
end
