Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations'}
  devise_scope :user do
    get "registrations/change_password"=> "registrations#change_password", :as => "change_password_registration"
    #get "registrations/new" => "registrations#new", :as =>"show"
    #get 'sign_up', to: 'registrations/#new'
    post 'usercreate', to: 'users#usercreate', as:'usercreate'
    get  'usernew/:id',    to: 'users#usernew', as:'usernew'
  end
  root 'companys#index'

   resources :companys do
    member do
      get 'remove_user'
      get 'del_modal'
    end
  end
  resources :users
  resources :tasks do
    member do
      post 'complete_task'
      post 'incomplete_task'
    end
  end
  # post "/complete_task", to: "tasks#complete_task"
   post "del_company", to: "companys#del_company"


end
