class Program < ApplicationRecord
  validates :name, :description, presence: true

  has_many :techniques, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :coaches_programs, dependent: :destroy
  has_many :coaches, through: :coaches_programs

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[coaches coaches_programs techniques users]
  end
end
