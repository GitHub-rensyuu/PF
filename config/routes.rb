Rails.application.routes.draw do
  # 会員
  scope module: "public" do
    root :to =>"homes#top"
    get "/about"=>"homes#about"
    get "/chart"=>"homes#chart"
    get "/search"=> "searches#search"
    get '/search/sort' => 'searches#sort'
    match 'search' => 'sources#search', via: [:get, :post]
    get "sources/search_tag"=>"sources#search_tag"
    resources :notices, only: [:index, :destroy]
    
    resources :sources do
      resources:recommends, only: [:create, :edit, :destroy]
      resource:likes, only: [:create, :destroy]
      resources:comments, only: [:create, :destroy] do
        resources:usefuls, only: [:create, :destroy]
      end
    end

    devise_for :customers, skip: [:passwords], controllers: {registrations: "public/registrations", sessions: "public/sessions"} 
    
    devise_scope :customer do
      post 'customers/guest_sign_in', to: 'sessions#guest_sign_in'
    end
    
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get :follows, :followers, :withdraw_confirm, :reporteds, :reporters, :chart,:likes
        patch :withdraw
      end
      resource :follows, only: [:create, :destroy]
      resource :reports, only: [:create, :destroy]
      resources:recommends, only: [:index]
      resources:likes, only: [:index]
    end

  end

  # 管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :destroy]
    resources :sources, only: [:index, :show, :destroy]
    resources :searches, only: [:index]
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
