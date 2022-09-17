class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.references :project, foreign_key: true, null: false

      t.string     :title, null: false
      t.text       :description
      t.text       :acceptance_criteria, null: false

      t.timestamps
    end
  end
end
