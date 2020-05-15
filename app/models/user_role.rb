class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :master_role
end
