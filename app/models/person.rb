class Person < ActiveRecord::Base
    has_many :dogs
    validates :name, presence: true
    validates :email, presence: true
end
