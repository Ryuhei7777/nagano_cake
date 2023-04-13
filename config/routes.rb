Rails.application.routes.draw do
  namespace :admin do
    resources :order_details, only: [:update]
  end
  namespace :admin do
    resources :orders, only: [:show, :update]
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  namespace :admin do
    root to: 'homes#top'
  end
  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  scope module: :public do
    resources :orders, only: [:new, :create, :index, :show]
  end
  post "/orders/confirm" => "public/orders#confirm", as: "public_orders_confirm"
  get "/orders/thanks" => "public/orders#thanks", as: "public_orders_thanks"

  scope module: :public do
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end
  delete "/cars_items/destroy_all" => "public/cars_items#destroy_all", as: ""

  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
  end
  get "/customers/withdraw_check" => "public/customers#withdraw_check", as: "withdraw_check"
  patch "/customers/withdraw" => "public/customers#withdraw", as: ""

  scope module: :public do
    resources :registrations, only: [:new, :create]
  end
  scope module: :public do
    resources :items, only: [:index, :show]
  end
  root to: 'public/homes#top'
  get "/about" => "public/homes#about", as: "public_about"

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
