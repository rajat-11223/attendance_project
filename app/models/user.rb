class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #User has many mobile number      
  has_many :mobiles

  
  has_many :user_roles
  has_many :master_roles, through: :user_roles

  belongs_to :designation, optional: true
  belongs_to :department, optional: true

  mount_uploader :image, ImageUploader
end
