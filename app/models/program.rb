class Program < ApplicationRecord
  validates :name, :description, presence: true

  has_many :techniques
  has_many :users
end
