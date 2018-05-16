Rails.application.routes.draw do
  resources :market_monitors
  resources :add_symbols, only: [:index, :new, :edit, :create]
  get 'add_symbols/new_symbols'
  get 'scans/demo'

  root 'pages#frontpage'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
