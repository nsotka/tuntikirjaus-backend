class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id, presence: true
  validates :task_id, presence: true
  validates :working_time, presence: true
end
