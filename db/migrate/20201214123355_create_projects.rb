class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.datetime :start_time, null: false
      t.datetime :end_time

      t.timestamps
    end
  end
end
