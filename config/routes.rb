Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  get '/posts/latest', to: 'posts#latest', as: 'latest'
  get '/posts/most_popular', to: 'posts#most_popular', as: 'most_popular'
  resources :posts
end
