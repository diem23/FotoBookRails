Rails.application.routes.draw do


  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check
  get "/", to: "feed#photo"
  get "/authenticate/login", to: "authentication#login"
  get "/authenticate/signup", to: "authentication#signup"
  get "/feed/album", to: "feed#album"
  get "/discover/photo", to: "discover#photo"
  get "/discover/album", to: "discover#album"
  get "/articles", to: "articles#index"
  put "/discover/follow", to: "discover#follow", as: :follow, defaults: { format: :json }
  get "/personal_info/photo", to: "personal_info#photo"
  scope module: 'users' do
    resources :photos, :albums
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
