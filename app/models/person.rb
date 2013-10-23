class Person < ActiveRecord::Base
    has_many :dogs
    has_secure_password
    validates_uniqueness_of :email
end
