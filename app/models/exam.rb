class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :answersheets, dependent: :destroy

  scope :created_sort, -> {order created_at: :desc}
end
