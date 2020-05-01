Rails.application.routes.draw do
  scope module: :users do
  	get "dashboard" => 'custom#dashboard', as: "dashboard"
  	devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  end

  
  

      root to: 'users/custom#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
