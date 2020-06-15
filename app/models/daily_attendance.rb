class DailyAttendance < ApplicationRecord


belongs_to :user
belongs_to :master_attendance_status
#scope :current_month, -> { where("created_at = Time.now.beginning_of_month..Time.now.end_of_month") }
scope :current_month, -> { where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month) }
scope :current_day, -> { where("created_at > ? AND created_at < ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }


end
