class Code < ActiveRecord::Base
  has_many :members, class_name: 'Code', foreign_key: 'set_id'
  belongs_to :set,   class_name: 'Code'
  validates :set, :code, :description, presence: true
end
