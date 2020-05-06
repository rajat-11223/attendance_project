class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

before_validation :confirmation_token, on: :create


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

end
