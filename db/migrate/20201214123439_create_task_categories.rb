class CreateTaskCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :task_categories do |t|
      t.string :category_name

      t.timestamps
    end
  end
end
