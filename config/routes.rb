Zendogs::Application.routes.draw do

  resources :lessons

  get 'register', to: 'people#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'debug', to: 'debug#index'

  resources :sessions

  resources :testimonials

  resources :courses

  %w[home about services contact].each do |page|
    get page, controller: "pages", action: page
  end

  resources :people

  resources :dogs do
    resources :notes
  end

  root to: 'pages#home'

end
