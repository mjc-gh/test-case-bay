class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, null: false

      t.string     :title, null: false
      t.text       :description

      t.integer    :suites_count, default: 0

      t.timestamps
    end
  end
end
