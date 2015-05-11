class User < ActiveRecord::Base
  has_many :exams, dependent: :destroy
end
