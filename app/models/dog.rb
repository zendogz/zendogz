class Dog < ActiveRecord::Base
  has_many :notes
  belongs_to :person
  validates :name, presence: true
end
