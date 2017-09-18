Rails.application.routes.draw do
#root "users#index"
#resources :users

devise_for :users, :controllers => { registrations: 'registrations' }
devise_scope :user do
  get "registrations/change_password"=> "registrations#change_password", :as => "change_password_registration"
end
root 'users#index'
 resources :users
end
