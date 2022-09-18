class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :run, foreign_key: true, null: false

      t.string     :token
      t.string     :email

      t.boolean    :completed, default: false, null: false
      t.boolean    :passed, default: false

      t.timestamps
    end
  end
end
