class CreateRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :runs do |t|
      t.references :project, foreign_key: true, null: false

      t.string     :title, null: false
      t.text       :description

      t.integer    :case_runs_count, default: 0, null: false
      t.integer    :assignments_count, default: 0, null: false

      t.timestamps
    end
  end
end
