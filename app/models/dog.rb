class Dog < ActiveRecord::Base
  has_many :notes
  belongs_to :person
  validates :name, presence: true

  def self.for(user)
    if (user)
      return Dog.all if user.role?(:admin)
      return user.dogs
    end
    nil
  end
end
