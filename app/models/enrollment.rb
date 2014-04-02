class Enrollment < ActiveRecord::Base
  belongs_to :person
  belongs_to :course
  belongs_to :status, class_name: 'Code'

end
