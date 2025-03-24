# class which represents admins
class Admin < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true, confirmation: true
end
