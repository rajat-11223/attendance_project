Rails.application.routes.draw do
  resources :dashboards
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations:'users/registrations',
        confirmations: 'users/confirmations'
      }


     
        post "register" =>"dashboards#register", as: :register	
        post "send_invitation" => "dashboards#send_invitation", as: :send_invitation
        get "employes_registered" => "dashboards#employes_registered"
        get "add_new_employe" => "dashboards#add_new_employe",as: :add_new_employe
      root 'dashboards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
