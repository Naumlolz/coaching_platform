class User < ApplicationRecord
  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
  # validates :age, numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 99 }
  validates :email, uniqueness: true, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :coach, optional: true
  belongs_to :program, optional: true
  has_many :users_techniques, dependent: :destroy
  has_many :techniques, through: :users_techniques
  has_many :users_techniques_ratings, dependent: :destroy
  has_many :users_coaches_invitations, dependent: :destroy
  has_many :user_completed_steps, dependent: :destroy
  has_many :steps, through: :user_completed_steps
  has_many :messages, dependent: :destroy
  has_one :users_techniques_time, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      age coach_id created_at description email first_name gender id last_name password
      program_id reset_password_code reset_password_code_sent_at updated_at
    ]
  end

  # def total_time_spent
  #   user_completed_steps.sum { |step| step.time_spent || 0 }
  # end

  delegate :total_time_spent, to: :users_techniques_time

  def coach?
    coach.present?
  end

  def public_name
    [first_name, last_name].join(' ')
  end
end
