Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get 'main/index', as: :main_index
  get 'main/new', as: :new_main
  post 'main/create', as: :create_main
  post 'main/import', as: :import_main
  get 'main/:token/edit', to: 'main#edit', as: :edit_main
  patch 'main/:token', to: 'main#update', as: :update_main
  delete 'main/:token', to: 'main#delete', as: :delete_main
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
