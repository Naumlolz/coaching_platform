class Coach < ApplicationRecord
  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
  validates :email, uniqueness: true, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :users, dependent: :nullify
  has_many :users_coaches_invitations, dependent: :destroy
  has_many :coaches_programs, dependent: :destroy
  has_many :programs, through: :coaches_programs
  has_many :messages, dependent: :destroy

  def public_name
    [first_name, last_name].join(' ')
  end
end
