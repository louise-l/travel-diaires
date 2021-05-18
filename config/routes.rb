Rails.application.routes.draw do

  devise_for :authors
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      resources :articles, only: [ :index, :show, :update, :create, :destroy ] do 
        resources :reviews, only: [:create, :destroy]
        collection do 
          # ajout de la route pour le tri par notes
          get '/order', to: 'articles#order'
        end
      end
      resources :categories, only: [:show, :index]
      resources :authors, only: [:index]
    end  
  end  

end
