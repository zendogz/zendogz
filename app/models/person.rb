class Person < ActiveRecord::Base
  has_many :dogs
  has_secure_password
  validates_uniqueness_of :email

  ROLES = %w[admin owner user]

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
end
