class TaskCategory < ApplicationRecord
    has_many :tasks

    validates :category_name, presence: true
end
