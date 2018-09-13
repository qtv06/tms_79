class User < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :user_tasks, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/i

  enum roles: {suppervisor: 0, trainee: 1}

  has_secure_password
  validates :name, presence: true,
    length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true,
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :phone_number, presence: true,
    length: {minimum: Settings.user.min_length_phone_number},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true,
    length: {maximum: Settings.user.max_length_address}
  validates :password, :password_confirmation, presence: true,
    length: {minimum: Settings.user.min_length_password}

  mount_uploader :avatar, AvatarUploader

  scope :get_suppervisors, ->{where role: roles[:suppervisor]}
  scope :get_trainees, ->{where role: roles[:trainee]}
  scope :newest, ->{order created_at: :desc}

  def is_suppervisor?
    role.zero?
  end
end
