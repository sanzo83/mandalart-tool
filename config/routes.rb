Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'welcome/index'
  get 'main/index'
  get 'main/new'
  post 'main/create'
  get 'main/edit'
  post 'main/update'
  get 'main/delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
