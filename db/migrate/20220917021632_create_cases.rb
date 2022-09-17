class CreateCases < ActiveRecord::Migration[7.0]
  def change
    create_table :cases do |t|
      t.references :suite, foreign_key: true, null: false

      t.string     :title, null: false
      t.text       :description
      t.text       :acceptance_criteria, null: false

      t.integer    :steps_count, default: 0

      t.timestamps
    end
  end
end
