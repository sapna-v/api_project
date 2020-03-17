Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'auth/signup', to: 'users#signup'
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'

  get 'all_users', to: 'users#index'

  post 'create_user', to: 'users#create'
  put 'edit_user', to: 'users#edit'
  delete 'delete_user', to: 'users#delete'

  get 'sort_users', to: 'users#sort'
  get 'filter_users', to: 'users#filter'
  post 'disable_user', to: 'users#disable'

  get 'all_tags', to: 'tags#index'
  post 'create_tag', to: 'tags#create'
  put 'edit_tag', to: 'tags#edit'
  delete 'delete_tag', to: 'tags#delete'
  get 'sort_tags', to: 'tags#sort_tags'
  post 'add_tag', to: 'users#add_tag'
  post 'remove_tag', to: 'users#remove_tag'
end
