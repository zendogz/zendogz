class Course < ActiveRecord::Base
  has_many :lessons
  validates :name, :description, presence: true
end
