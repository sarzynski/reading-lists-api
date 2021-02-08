Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :lists, only: :index
  end  
    
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :lists do
      resources :books
    end
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
