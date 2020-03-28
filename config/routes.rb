Rails.application.routes.draw do
  root to: 'applications#index'

  resources :links, only: [:new, :create, :show] do
    get 'detail'
  end
end
