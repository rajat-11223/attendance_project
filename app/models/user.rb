class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable,:confirmable,:trackable

before_validation :confirmation_token, on: :create
has_many :daily_attendances 
has_many :request_leaves 

 has_many :mobiles

  
  has_many :user_roles
  has_many :master_roles, through: :user_roles

  belongs_to :designation, optional: true
  belongs_to :department, optional: true

  mount_uploader :image, ImageUploader
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
