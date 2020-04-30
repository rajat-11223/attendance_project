begin
    puts 'Master Role initializing...'
    MasterRole.destroy_all
    MasterRole.create!([{ id: 1, role_name: 'admin' },
                        { id: 2, role_name: 'employe' }])
    puts 'Master Role initialized successfully'

puts 'Master Attendance Status initializing...'
    MasterAttendanceStatus.destroy_all
    MasterAttendanceStatus.create!([{ id: 1, status: 'present' },
                        { id: 2, status: 'half day' },{id: 3, status: 'leave' },{id: 4, status: 'wfh' }])
    puts 'Master Attendance Status initialized successfully'

    rescue Exception => e
  puts "Exception Raised at #{Time.current} #{e.message}"
  puts "Exception Raised at #{Time.current} #{e.backtrace}"
  end