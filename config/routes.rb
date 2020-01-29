Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [] do
    resources :tweets
  end

  get '/follow_users', to: 'home#follow_users', as: :follow_users
  get '/follow/:followed_id', to: 'relationships#follow', as: :follow_user
  get '/unfollow/:id', to: 'relationships#unfollow', as: :unfollow_user

  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:show] do
        member do
          get 'follow/:followed_id', action: 'follow'
          get 'unfollow/:unfollowed_id', action: 'unfollow'
        end
        resources :tweets, only: [:index] do
          get 'followings', on: :collection
        end
      end
    end
  end
end
