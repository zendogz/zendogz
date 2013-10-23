Zendogs::Application.routes.draw do

  get 'register', to: 'people#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions

  resources :testimonials

  resources :courses

  %w[home about services contact].each do |page|
    get page, controller: "pages", action: page
  end

  resources :notes

  resources :people

  resources :dogs

  root to: 'pages#home'

end
