Rails.application.routes.draw do
  # 会員
  scope module: "public" do
    root :to =>"homes#top"
    get "/about"=>"homes#about"
    get "/contributors"=>"homes#contributors"
    get "/reviewers"=>"homes#reviewers"
    get "/chart"=>"homes#chart"
    get "/search"=> "searches#search"
    resources :sources do
      resources:recommends, only: [:create, :edit, :destroy]
      resource:likes, only: [:create, :destroy]
      resources:comments, only: [:create, :destroy] do
        resources:usefuls, only: [:create, :destroy]
      end
    end

    devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get :follows, :followers, :withdraw_confirm
        patch :withdraw
      end
      resource :follows, only: [:create, :destroy]
      resource :reports, only: [:create, :destroy]
      resources:recommends, only: [:index]
      resources:likes, only: [:index]
    end

   namespace :public do
      get "likes/index"
      get "likes/create"
      get "likes/destroy"
      get "news/index"
      get "news/show"
    end

  end

  # 管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get "likes/index"
    get "news/index"
    get "news/show"
    get "news/new"
    get "news/create"
    get "news/update"
    get "news/public_update"
  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
