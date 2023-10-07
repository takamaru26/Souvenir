Rails.application.routes.draw do
root to: 'user/homes#top'
get '/search', to: 'searches#search'
get 'tagsearches/search', to: 'tagsearches#search'

#管理者用
namespace :admin do
  root to: "homes#top"
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :edit, :create, :update]
end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


#顧客用
namespace :user do
    resources :items, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
    resources :item_comments, only: [:create, :destroy]
  end
  resources :users, only: [:new,:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end

# 顧客用
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

#ゲストユーザー用
devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
 end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
