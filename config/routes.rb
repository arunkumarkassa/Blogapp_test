Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users,controllers: {registrations: "users/registrations"}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles
  get 'search',to:'articles#search'
  get 'bulkdata',to:"articles#bulkdata"
  post 'import',to:"articles#import"
  get 'export',to:"articles#export_csv"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
