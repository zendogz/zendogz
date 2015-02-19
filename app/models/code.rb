class Code < ActiveRecord::Base
  has_many :members, class_name: 'Code', foreign_key: 'set_id'
  belongs_to :set,   class_name: 'Code'
  validates :code, :description, presence: true

  def self.list_for(set)
    Code.where(code: set).first.members
  end
  
  def self.code_for(set, code)
    root = Code.where(code: set).first
    root.members.where(code: code).first
  end

end
