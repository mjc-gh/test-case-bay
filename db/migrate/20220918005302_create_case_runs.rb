class CreateCaseRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :case_runs do |t|
      t.references :case, foreign_key: true, null: false
      t.references :run, foreign_key: true, null: false

      t.integer    :row_order

      t.timestamps
    end
  end
end
