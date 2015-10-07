class Note < ActiveRecord::Base
  belongs_to :dog
  validates :note, :dog, presence: true
end
