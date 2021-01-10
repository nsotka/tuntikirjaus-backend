class Project < ApplicationRecord
    has_many :tasks, dependent: :delete_all
    has_many :user_tasks, :through => :tasks

    validates :project_name, presence: true
    validates :start_time, presence: true
end
