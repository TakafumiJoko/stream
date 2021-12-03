class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references :watched_by, null: false, foreign_key: true

      t.timestamps
    end
  end
end
