class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.datetime :start_time
      t.datetime :end_time
      t.references :project, null: false, foreign_key: true
      t.references :task_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
