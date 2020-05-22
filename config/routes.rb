Rails.application.routes.draw do

  #resources :dashboards



scope module: :users do
  	#get "users/admindashboard" => 'custom#admindashboard'
  	get "users/attendance" => 'custom#attendance', as: "attendance"

  	get "users/request_leave" => 'custom#request_leave', as: "request_leave"

  	post "users/apply_leave" => 'custom#apply_leave', as: "apply_leave"

  	post "punch_attendance"  => 'custom#punch_attendance', as: 'punch_attendance'



  	get "dashboard" => 'custom#dashboard', as: "dashboard"
  	get "employees" => 'custom#employees', as: "employees"
  	get "admin_edit_user/:id" => 'custom#admin_edit_user', as: "edit_user"


    get "admin_create_user" => 'custom#admin_create_user', as: "new_user"

    post "update_user/:id" => 'custom#update_user', as: "update_user"

    post "add_new_employee" => 'custom#add_new_employee', as: "add_new_employee"

    get "user_profile/:id" => 'custom#user_profile', as: "user_profile"

    post "save_user_image" => 'custom#save_user_image', as: "save_user_image"

  	root to: "custom#dashboard"


  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations:'users/registrations',
        confirmations: 'users/confirmations',
        passwords: 'users/passwords'

      }
  end

  
	
  

#  scope module: :users do 
#	scope :users do
]
#
#	   get "set_password" => "sessions#set_password"
#    end
#    end

     
     #   post "register" =>"dashboards#register", as: :register	
     #   post "send_invitation" => "dashboards#send_invitation", as: :send_invitation
     #   get "employes_registered" => "dashboards#employes_registered"
     #   get "add_new_employe" => "dashboards#add_new_employe",as: :add_new_employe
     #   root 'custom#attendance'
     #   For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
