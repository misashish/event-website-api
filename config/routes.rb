Rails.application.routes.draw do
  root to: 'home#index'
	
	
  # delete "/users/sign_out" => "users#destroy"
  devise_for :users, :controllers => {confirmations: 'confirmations',registrations: "users/registrations", sessions: "users/sessions", omniauth_callbacks: 'callbacks',passwords: 'users/passwords' }
  #namespace "api/v1", :as=>:api do
  
  namespace :app do
    namespace :api do
      namespace :admin do
        
        get "/" => "dashboards#index"

        #users Api's
        get "listusers" => "users#all_users"
        delete "listusers/:id" => "users#delete_user" , as: "user_delete"
        patch "/users/update" => "users#update"
        get  "/profile" => "users#show", as: "user_profile"
        post '/users_list' => "users#get_users_list"
  	    post  "/users/setting" => "users#edit"
        post  "/users/activeDeactve" => "users#change_status"

        #categories Api's
        get 'categorylist' => "categories#index"
        post 'categories' => "categories#create"
        patch 'categories/:id' => "categories#update"
        delete  'categories/:id' => "categories#destroy"
        post '/category_list' =>"categories#get_category_list"
        get '/categories/:id/edit' => "categories#edit"
        post  "/categories/activeDeactve" => "categories#change_status"
        
        # Artists Api's
        resources :artists , :only =>[:index, :create, :update, :destroy, :edit]
        
        get '/artist_list' =>"artists#get_artist_list"
        post  "/artists/activeDeactve" => "artists#change_status"
        
        # Events Api's
        resources :events , :only =>[:index, :create, :update, :show, :edit, :destroy]

        post '/all_event_list' => "events#get_event_list"
        post '/latestEvent' => "events#latest_event"
        post '/event_list/:event_type' => "events#event_list"
        post  "/events/activeDeactve" => "events#change_status"

        # user and events count api's

        get '/usr_evnt_count'  => "dashboards#usr_event"

      end
    end
  end
end
