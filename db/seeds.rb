begin
    puts 'Master Role initializing...'
    MasterRole.destroy_all
    MasterRole.create!([{ id: 1, role_name: 'admin' },
                        { id: 2, role_name: 'employee' }])
    puts 'Master Role initialized successfully'

    puts 'Master Attendance Status initializing...'
    MasterAttendanceStatus.destroy_all
    MasterAttendanceStatus.create!(
      [
        { id: 1, status: 'present' },
        { id: 2, status: 'half day' },
        {id: 3, status: 'leave' },
        {id: 4, status: 'work from home' }
    ])
    puts 'Master Attendance Status initialized successfully'

    puts 'Master Designation initializing...'
    Designation.destroy_all
    Designation.create!(
      [
        { id: 1, designation_name: 'Director' },
        { id: 2, designation_name: 'Manager' },
        {id: 3, designation_name: 'Product Manager' },
        {id: 4, designation_name: 'Senior Consultant' },
        {id: 5, designation_name: 'Consultant' },
        {id: 6, designation_name: 'Associate' },
        {id: 7, designation_name: 'HR Manager' }
    ])
    puts 'Designation initialized successfully'

    puts 'Master Department initializing...'
    Department.destroy_all
    Department.create!(
      [
        { id: 1, department_name: 'Technology' },
        { id: 2, department_name: 'Project Management' },
        {id: 3, department_name: 'Design' },
        {id: 4, department_name: 'System Architect' },
        {id: 5, department_name: 'Quality Assurance' },
        {id: 6, department_name: 'Digital Marketing' }
        
    ])
    puts 'Department initialized successfully'

    User.destroy_all
    user = User.new(
      :email                 => "rajat@poplify.com",
      :password              => "123456",
      :designation_id        => 1,
      :department_id       => 1
      
    )
    
    user.save!
    puts 'Admin initialized successfully'


    puts 'UserRole initializing...'
    UserRole.destroy_all
    UserRole.create!(
      [
        { id: 1, user_id: 1,master_role_id: 1 }
       
    ])
    puts 'UserRole initialized successfully'

    rescue Exception => e
  puts "Exception Raised at #{Time.current} #{e.message}"
  puts "Exception Raised at #{Time.current} #{e.backtrace}"
  end