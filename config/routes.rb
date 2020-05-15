Rails.application.routes.draw do




  scope module: :users do
    
  	get "dashboard" => 'custom#dashboard', as: "dashboard"

  	get "employees" => 'custom#employees', as: "employees"

  	get "admin_edit_user/:id" => 'custom#admin_edit_user', as: "edit_user"

    get "admin_create_user" => 'custom#admin_create_user', as: "new_user"

    put "admin_update_user/:id" => 'custom#admin_update_user', as: "update_user"

  	devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  end

  
	
  
  

  root to: 'users/custom#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
