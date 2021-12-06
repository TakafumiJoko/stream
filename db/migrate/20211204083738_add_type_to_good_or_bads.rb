class AddTypeToGoodOrBads < ActiveRecord::Migration[6.0]
  def change
    add_column :good_or_bads, :type, :integer
  end
end
