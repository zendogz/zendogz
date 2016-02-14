class Person < ActiveRecord::Base
  has_many :dogs
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_secure_password
  validates :email, uniqueness: true
  validates :name, :password, :email, presence: true

  ROLES = %w(admin owner user)

  def roles=(roles)
    self.authority = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((authority || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def admin?
    self.role?(:admin)
  end

  def owner?
    self.role?(:owner)
  end

  def enroll(course)
    courses << course if course
    save
  end

  def enrolled?(course)
    courses.include?(course) if course
  end

  def login(session)
    session[:user_id] = id
  end
end
