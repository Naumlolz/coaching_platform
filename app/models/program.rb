class Program < ApplicationRecord
  validates :name, :description, presence: true

  has_many :techniques, dependent: :destroy
  has_many :users
  has_many :coaches_programs
  has_many :coaches, through: :coaches_programs
end
