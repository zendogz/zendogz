class Lesson < ActiveRecord::Base
  belongs_to :course
  belongs_to :status, class_name: 'Code'
  validates :name, presence: true
end
