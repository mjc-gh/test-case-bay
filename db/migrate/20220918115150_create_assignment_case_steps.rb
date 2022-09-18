class CreateAssignmentCaseSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :assignment_case_steps do |t|
      t.references :assignment, foreign_key: true, null: false
      t.references :case, foreign_key: true, null: false

      t.datetime   :completed_at
      t.boolean    :completed, default: false, null: false
      t.boolean    :passed, default: false

      t.text       :notes

      t.timestamps
    end
  end
end
