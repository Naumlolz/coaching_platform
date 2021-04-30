class Program < ApplicationRecord
  has_many :techniques
  has_many :users
end
