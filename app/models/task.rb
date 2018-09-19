class Task < ApplicationRecord
  belongs_to :subject
  has_many :user_tasks, dependent: :destroy

  validates :name, :description, presence: true

  scope :newest, ->{order created_at: :desc}
end
