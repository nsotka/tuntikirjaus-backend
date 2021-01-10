class CreateUserTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :working_time

      t.timestamps
    end
    add_index :user_tasks, [:user_id, :task_id], unique: true
  end
end
