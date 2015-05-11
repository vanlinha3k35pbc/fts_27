class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :answersheets, dependent: :destroy
end
