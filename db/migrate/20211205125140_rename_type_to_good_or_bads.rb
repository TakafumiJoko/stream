class RenameTypeToGoodOrBads < ActiveRecord::Migration[6.0]
  def change
    rename_column :good_or_bads, :type, :evaluation_type
  end
end
