class User < ApplicationRecord
  before_save :convert_role_to_int

  has_many :user_courses, dependent: :destroy
  has_many :user_tasks, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/i

  enum role: {suppervisor: 0, trainee: 1}

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
    length: {minimum: Settings.user.min_length_password}, allow_blank: true

  mount_uploader :avatar, AvatarUploader

  scope :newest, ->{order created_at: :desc}
  scope :with_a_role, ->(role){where(role: role)}
  scope :not_exit_on_course, ->(course_id) do
    where("id not in (?)", UserCourse.user_id_on_course(course_id))
  end

  def convert_role_to_int
    self.role = User.roles[role]
  end
end
