class Category < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: true}
  validates :description, presence: true

  scope :alphabet_sort, -> {order name: :asc}
end
