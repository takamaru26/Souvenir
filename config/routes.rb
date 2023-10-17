Rails.application.routes.draw do
root to: 'public/homes#top'
get "search_tag" => "items#search_tag"

#管理者用
namespace :admin do
  root to: "homes#top"
  resources :users, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :edit, :create, :update]
end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


#顧客用
namespace :public do
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
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
 end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
