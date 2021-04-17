Rails.application.routes.draw do
  get 'admin/search/search'
  root to: 'public/homes#home'
  get 'home/about' => 'public/homes#about'
  get 'public/unsubscribe' => 'public/customers#unsubscribe'
  patch 'public/withdraw/:id' => 'public/customers#withdraw' ,as:'publics_withdraw'
  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all'
  post 'public/orders/comfirm' => 'public/orders#comfirm',as:'publics_order_comfirm'
  get 'public/orders/complete' => 'public/orders#complete',as:'publics_order_complete'
  get 'admin/homes/top' => 'admin/homes#top'
  patch 'admin/order_details/:id' => 'admin/order_items#update',as:'order_items'

  devise_for :customers, controllers: {
    sessions:      'public_devises/sessions',
    passwords:     'public_devises/passwords',
    registrations: 'public_devises/registrations'
  }
  namespace :public do
    resources :customers, :only => [:show, :edit,:update]
    resources :items, :only => [:show,:index]
    resources :cart_items, :only => [:index, :update, :create, :destroy] do
      delete "all_destroy"
  end
    resources :orders ,:only => [:index,:show,:new,:create]
    resources :addresses, :only => [:index,:edit,:create,:update,:destroy]
  end

  devise_for :admins, controllers: {
    sessions:      'admin_devises/sessions',
    passwords:     'admin_devises/passwords',
    registrations: 'admin_devises/registrations'
  }
  namespace :admin do
    resources :items, :only => [:index,:show,:new,:create,:edit,:update]
    resources :genres, :only => [:index,:create,:edit,:show,:update]
    resources :customers, :only => [:index,:show,:edit,:update]
    resources :orders, :only => [:show,:update]
  end
end