class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, 
  :rememberable, :validatable,:trackable
mount_uploader :image, AvatarUploader

before_validation :confirmation_token, on: :create
has_many :daily_attendances 
has_many :request_leaves 

 has_many :mobiles

  belongs_to :department
  belongs_to :designation
  has_many :user_images
   accepts_nested_attributes_for :user_images
  has_many :user_roles
  has_many :master_roles, through: :user_roles

  

  
#
#def generate_confirmation_token
#  raw, enc = Devise.token_generator.generate(self.class, :confirmation_token)
#  @raw_confirmation_token   = raw
#  self.confirmation_token   = enc
#  self.confirmation_sent_at = Time.now.utc
#end
#



#private
#def confirmation_token

	#puts "value reach here"
      
       #   self.confirmation_token = SecureRandom.urlsafe_base64(10)
        #  self.confirmation_sent_at = Time.now.utc

     
   # end



  #User has many mobile number      


 


end
