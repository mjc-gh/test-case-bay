class CreateSuites < ActiveRecord::Migration[7.0]
  def change
    create_table :suites do |t|
      t.references :project, foreign_key: true, null: false

      t.string     :title, null: false
      t.text       :description

      t.integer    :cases_count, default: 0

      t.timestamps
    end
  end
end
