class User < ActiveRecord::Base
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :exams, dependent: :destroy

  enum role: [:admin, :registered]

  mount_uploader :avatar, AvatarUploader

  validate :avatar_size

  private
  def avatar_size
    if avatar.size > Settings.max_avatar_file_size.megabytes
      errors.add :avatar,
        "should be less than #{Settings.max_avatar_file_size}MB"
    end
  end

  def set_default_role
    self.role ||= "registered"
  end
end
