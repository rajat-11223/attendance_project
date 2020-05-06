class RegisterEmploye < ApplicationRecord

	validates :email, uniqueness: true, on: :create
end
