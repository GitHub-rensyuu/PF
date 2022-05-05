Rails.application.routes.draw do
  # 会員
  scope module: 'public' do
    root :to =>'homes#top'
    get "/about"=>'homes#about'
    get "/contributors"=>'homes#contributors'
    get "/reviewers"=>'homes#reviewers'
    get "/chart"=>'homes#chart'
    resources :sources


    devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
   namespace :public do
      get 'likes/index'
      get 'likes/create'
      get 'likes/destroy'
      get 'news/index'
      get 'news/show'
    end

  end

  # 管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get 'likes/index'
    get 'news/index'
    get 'news/show'
    get 'news/new'
    get 'news/create'
    get 'news/update'
    get 'news/public_update'
  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
