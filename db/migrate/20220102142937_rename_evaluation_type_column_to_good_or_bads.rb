class RenameEvaluationTypeColumnToGoodOrBads < ActiveRecord::Migration[6.0]
  def change
    rename_column :good_or_bads, :evaluation_type, :value
  end
end
