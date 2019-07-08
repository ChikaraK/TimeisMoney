Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/cfdb', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
  	root to: "devise/sessions#new"
  end
  resources :timecards, only:[:index,:show,:create,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
