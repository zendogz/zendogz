class Course < ActiveRecord::Base
  has_many :lessons
  has_many :enrollments
  has_many :students, through: :enrollments, source: :person
  validates :name, :description, presence: true
end
