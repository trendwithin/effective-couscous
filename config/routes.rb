Rails.application.routes.draw do
  resources :market_monitors
  get 'scans/demo'

  root 'pages#frontpage'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
