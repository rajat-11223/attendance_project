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

  
def check_present(uid)


 user_online = DailyAttendance.find_by(user_id: uid, created_at: Date.today.all_day)
 user_online.present? ? 'present' : 'not-present'

end 

def working_days(uid)

work_day = DailyAttendance.where(user_id:uid, created_at: Time.now.beginning_of_month..Time.now.end_of_month )
work_day ? work_day.count : 0
 end 
  
def current_month_average(uid)

month_average = DailyAttendance.where(user_id:uid, created_at: Time.now.beginning_of_month..Time.now.end_of_month )
worked_days = month_average.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }
@calculated_avrg = worked_days.map{|n| Time.at(n).utc.strftime("%k:%M")}
@calculated_avrg.present? ? find_avg_of_times(@calculated_avrg) : 0

#@avrg = @a.present? ? avg_of_times(@a) : 0 
 end 

 def previous_month(uid)

previous_month_average = DailyAttendance.where(user_id: uid, created_at: Time.now.beginning_of_month - 1.month ..Time.now.end_of_month - 1.month)
#byebug
worked_days = previous_month_average.where.not(punch_out: nil).map{ |n| n.punch_out.to_time - n.punch_in.to_time }
@calculated_avrg = worked_days.map{|n| Time.at(n).utc.strftime("%k:%M")}
@calculated_avrg.present? ? find_avg_of_times(@calculated_avrg) : 0

 end

def find_avg_of_times(array_of_time)
  size = array_of_time.size
  avg_minutes = array_of_time.map do |x|
    hour, minute = x.split(':')
    total_minutes = hour.to_i * 60 + minute.to_i
  end.inject(:+)/size

  "#{avg_minutes/60}:#{avg_minutes%60}"
end

def today_punch_in(uid)

today_punched_in = DailyAttendance.find_by(:user_id => uid, created_at: Date.today.all_day) 
today_punched_in.present?  ? today_punched_in.punch_in.present? ? today_punched_in.punch_in.strftime("%I:%M %P"): 'Not Punched' : 'Not Punched'

 
end  

def today_punch_out(uid)

today_punched_out = DailyAttendance.find_by(:user_id => uid, created_at: Date.today.all_day) 
today_punched_out.present?  ? today_punched_out.punch_out.present? ? today_punched_out.punch_out.strftime("%I:%M %P"): 'Not Punched' : 'Not Punched'

 
end

def daily_punched_status(uid)

daily_status = DailyAttendance.find_by(:user_id => uid, created_at: Date.today.all_day) 
daily_status.present?  ? daily_status.master_attendance_status.status ? daily_status.master_attendance_status.status.capitalize : 'Not Punched' : 'Not Punched'
end
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
