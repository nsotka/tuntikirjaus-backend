class Task < ApplicationRecord

  
  belongs_to :project
  belongs_to :task_category
  has_many :user_tasks, dependent: :delete_all
  has_many :users, :through => :user_tasks

  validates :project_id, presence: true
  validates :task_category_id, presence: true
  validates :task_name, presence: true
end
