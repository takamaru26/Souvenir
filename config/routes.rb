Rails.application.routes.draw do
  root to: 'public/homes#top'
  get "search_tag" => "public/items#search_tag"
  get '/search', to: 'public/items#search'

  #管理者用
  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show, :edit, :destroy] 
    resources :genres, only: [:index, :edit, :create, :update]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  #顧客用
  namespace :public do
    patch 'users/:user_id/nonrelease', to: 'users#update_nonrelease', as: 'update_nonrelease_user'
    patch 'users/:user_id/release', to: 'users#update_release', as: 'update_release_user'
    resources :items, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
      resources :item_comments, only: [:create, :destroy]
    end
    resources :users, only: [:new,:index,:show,:edit,:update] do
      get 'unfollow' => 'relationships#destroy', as: 'unfollow'
      get 'to_follow' => 'relationships#create', as: 'to_follow'
      get 'followings_show' => 'relationships#followings', as: 'followings'
      get 'followers_show' => 'relationships#followers', as: 'followers'
    end
  end

  # 顧客用
  # URL /public/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #devise_scope :user do
    # セッションコントローラのルートをカスタムセッションコントローラにマッピング
    #get 'users/sign_in' => 'public/sessions#new', as: :new_user_session
    #post 'users/sign_in' => 'public/sessions#create', as: :user_session
    #delete 'users/sign_out' => 'public/sessions#destroy', as: :destroy_user_session
  #end

  #ゲストユーザー用
  devise_scope :user do
    get 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
