class Testimonial < ActiveRecord::Base
  validates :from, :body, presence: true
end
