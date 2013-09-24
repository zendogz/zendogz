Zendogs::Application.routes.draw do

  %w[home about services contact].each do |page|
    get page, controller: "pages", action: page
  end

  resources :notes

  resources :people

  resources :dogs

  root to: 'pages#home'

end
