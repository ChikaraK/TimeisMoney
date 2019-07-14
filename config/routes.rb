Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/cfdb', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
  	root to: "timecards#show"
  	delete 'sign_out', to: 'devise/session#destroy', as: :sign_out
  end
  resources :timecards, only:[:index,:show,:create,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
