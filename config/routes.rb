Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'welcome/index'
  get 'main/index', as: :main_index
  get 'main/new', as: :new_main
  post 'main/create', as: :create_main
  get 'main/edit', as: :edit_main
  patch 'main/update', as: :update_main
  delete 'main/delete', as: :delete_main
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
