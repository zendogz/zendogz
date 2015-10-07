class Enrollment < ActiveRecord::Base
  belongs_to :person
  belongs_to :course
  belongs_to :status, class_name: 'Code'
  validates :person, :course, presence: true

  def add_student(current_user)
    if current_user && !current_user.admin?
      self.person = current_user
      save
    else
      build_person
      logger.info('building a user.. not logged in or logged in as admin')
      logger.info(inspect)
    end
  end
end
